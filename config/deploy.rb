require 'bundler/capistrano'
require 'capistrano/maintenance'
require 'sidekiq/capistrano'
require 'new_relic/recipes'
require 'thinking_sphinx/capistrano'

set :application, 'goodbre.ws'

server '192.81.210.163', :web, :app, :db, :primary => true

set :repository,  'git@github.com:davidcelis/goodbre.ws.git'
set :branch, 'master'
set :scm, :git

set :user, 'david'
set :use_sudo, false
set :deploy_to, "/home/david/apps/#{application}"
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :default_environment, {
  'PATH' => "/home/david/.rbenv/shims:/home/david/.rbenv/bin:$PATH"
}

namespace :deploy do
  desc 'Start puma server'
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && NEWRELIC_DISPATCHER=puma bundle exec puma -C config/puma.rb --control unix://#{shared_path}/sockets/pumactl.sock >> #{shared_path}/log/puma-production.log 2>&1 &", :pty => false
  end

  desc 'Stop puma server'
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec pumactl -S #{shared_path}/pids/puma.state stop"
  end

  desc 'Restart puma server'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec pumactl -S #{shared_path}/pids/puma.state restart"
  end

  desc 'Get status of puma server'
  task :status, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec pumactl -S #{shared_path}/pids/puma.state stats"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    run "mkdir -p #{shared_path}/config/initializers"
    put File.read("config/analytics.yml"), "#{shared_path}/config/analytics.yml"
    put File.read("config/newrelic.yml"), "#{shared_path}/config/newrelic.yml"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/smtp.yml"), "#{shared_path}/config/smtp.yml"
    put File.read("config/initializers/secret_token.rb"), "#{shared_path}/config/initializers/secret_token.rb"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/analytics.yml #{release_path}/config/analytics.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/smtp.yml #{release_path}/config/smtp.yml"
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

after  'deploy:update_code',     'deploy:migrate'
after  'deploy:update',          'newrelic:notice_deployment'
after  'deploy',                 'deploy:cleanup'
