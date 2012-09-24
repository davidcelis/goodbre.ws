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
  'PATH' => "/home/david/.oh-my-zsh/custom/plugins/stephencelis/bin:/home/david/.rbenv/shims:/home/david/.rbenv/bin:/home/david/.rbenv/shims:/usr/local/bin:/usr/local/sbin:/usr/local/share/python:/home/david/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources://home/david/Library/Developer/flex_sdk_4/bin",
  'GEM_HOME' => '/home/david/.rbenv/versions/1.9.3-p194-perf/lib/ruby/gems/1.9.1/',
  'GEM_PATH' => '/home/david/.rbenv/versions/1.9.3-p194-perf/lib/ruby/gems/1.9.1/',
  'BUNDLE_PATH' => '/home/david/.rbenv/versions/1.9.3-p194-perf/lib/ruby/gems/1.9.1/gems/'
}

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      sudo "/etc/init.d/unicorn_#{application} #{command}" # Using unicorn as the app server
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_ini.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
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

before 'deploy:update_code', 'thinking_sphinx:stop'
after 'deploy:update_code', 'thinking_sphinx:start'

namespace :sphinx do
  desc "Symlink Sphinx indexes"
  task :symlink_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
end

after 'deploy:finalize_update', 'sphinx:symlink_indexes'
after 'deploy', 'deploy:cleanup'
