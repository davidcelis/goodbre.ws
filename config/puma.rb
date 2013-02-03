# Define your root directory
root = '/home/david/apps/goodbre.ws'
shared = "#{root}/shared"

# Bind to a UNIX socket
bind "unix://#{shared}/sockets/puma.sock"

environment 'production'
pidfile "#{shared}/pids/puma.pid"
state_path "#{shared}/pids/puma.state"

# 0-16 threads for production environment
threads 0, 16
