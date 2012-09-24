require 'bundler/capistrano'
require 'sidekiq/capistrano'
require 'thinking_sphinx/deploy/capistrano'

set :application, 'goodbre.ws'

server '74.207.230.240', :web, :app, :db, :primary => true

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
  'PATH' => "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH"
}

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}" # Using unicorn as the app server
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_ini.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config/initializers"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/smtp.yml"), "#{shared_path}/config/smtp.yml"
    put File.read("config/initializers/secret_token.rb"), "#{shared_path}/config/initializers/secret_token.rb"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
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

namespace :sphinx do
  desc "Symlink Sphinx indexes"
  task :symlink_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
end

after 'deploy:update_code', 'deploy:migrate'
before 'deploy:update_code', 'thinking_sphinx:stop'
after 'deploy:update_code', 'thinking_sphinx:start'
after 'deploy:finalize_update', 'sphinx:symlink_indexes'
after 'deploy', 'deploy:cleanup'
