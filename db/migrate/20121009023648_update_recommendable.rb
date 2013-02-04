class UpdateRecommendable < ActiveRecord::Migration
  def up
    # Recommendable.redis.flushdb # Step 1

    # connection = ActiveRecord::Base.connection
    # # Transfer likes
    # result = connection.execute('SELECT * FROM recommendable_likes')
    # result.each do |row|
    #   liked_set = Recommendable::Helpers::RedisKeyMapper.liked_set_for(row['likeable_type'], row['user_id'])
    #   liked_by_set = Recommendable::Helpers::RedisKeyMapper.liked_by_set_for(row['likeable_type'], row['likeable_id'])
    #   Recommendable.redis.sadd(liked_set, row['likeable_id'])
    #   Recommendable.redis.sadd(liked_by_set, row['user_id'])
    # end

    # # Transfer dislikes
    # result = connection.execute('SELECT * FROM recommendable_dislikes')
    # result.each do |row|
    #   disliked_set = Recommendable::Helpers::RedisKeyMapper.disliked_set_for(row['dislikeable_type'], row['user_id'])
    #   disliked_by_set = Recommendable::Helpers::RedisKeyMapper.disliked_by_set_for(row['dislikeable_type'], row['dislikeable_id'])
    #   Recommendable.redis.sadd(disliked_set, row['dislikeable_id'])
    #   Recommendable.redis.sadd(disliked_by_set, row['user_id'])
    # end

    # # Transfer hidden items
    # result = connection.execute('SELECT * FROM recommendable_ignores')
    # result.each do |row|
    #   set = Recommendable::Helpers::RedisKeyMapper.hidden_set_for(row['ignorable_type'], row['user_id'])
    #   Recommendable.redis.sadd(set, row['ignorable_id'])
    # end

    # # Transfer bookmarks
    # result = connection.execute('SELECT * FROM recommendable_stashes')
    # result.each do |row|
    #   set = Recommendable::Helpers::RedisKeyMapper.bookmarked_set_for(row['stashable_type'], row['user_id'])
    #   Recommendable.redis.sadd(set, row['stashable_id'])
    # end

    # # Recalculate scores
    # Beer.pluck(:id).each { |id| Recommendable::Helpers::Calculations.update_score_for(Beer, id) }

    # Remove old tables. Uncomment this if you're feeling confident.
    # drop_table :recommendable_likes
    # drop_table :recommendable_dislikes
    # drop_table :recommendable_ignores
    # drop_Table :recommendable_stashes
  end

  def down
    # Recreate the tables from previous migrations, if you must.
  end
end
