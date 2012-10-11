require Rails.root.join('app', 'models', 'user')
require 'redis'

Recommendable.configure do |config|
  # Recommendable's connection to Redis
  config.redis = Redis.new(:host => 'localhost', :port => 6379, :db => 0)

  # A prefix for all keys Recommendable uses
  config.redis_namespace = :recommendable

  # Whether or not to automatically enqueue users to have their recommendations
  # refreshed after they like/dislike an item
  config.auto_enqueue = true

  # The name of the queue that background jobs will be placed in
  config.queue_name = :recommendable

  # The number of nearest neighbors (k-NN) to check when updating
  # recommendations for a user. Set to `nil` if you want to check all
  # other users as opposed to a subset of the nearest ones.
  # config.nearest_neighbors = nil
end
