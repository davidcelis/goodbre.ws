# Define your root directory
root = "/home/david/apps/goodbre.ws"

# Bind to a UNIX socket
bind 'unix:///tmp/puma.sock'

environment 'production'
pidfile "#{root}/shared/pids/puma.pid"
state_path "#{root}/shared/pids/puma.state"

# 0-16 threads for production environment
threads 0, 16
