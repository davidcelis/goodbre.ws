# Define your root directory
root = "/home/david/apps/goodbre.ws/current"

# Define worker directory for Unicorn
working_directory root

# Location of PID file
pid "#{root}/tmp/pids/unicorn.pid"

# Define Log paths
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

# Listen on a UNIX data socket
listen "/tmp/unicorn.goodbre.ws.sock"

# 16 worker processes for production environment
worker_processes 16

# Load rails before forking workers for better worker spawn time
preload_app true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
  # ...
end

# Restart workers hangin' out for more than 240 secs
timeout 240
