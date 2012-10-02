class AddCounterCachesToUsersAndBeers < ActiveRecord::Migration
  def up
    add_column :users, :likes_count, :integer
    add_column :users, :dislikes_count, :integer

    add_column :beers, :likes_count, :integer
    add_column :beers, :dislikes_count, :integer

    User.pluck(:id).each { |id| User.reset_counters(id, :likes, :dislikes) }
    Beer.pluck(:id).each { |id| Beer.reset_counters(id, :recommendable_likes, :recommendable_dislikes) }
  end

  def down
    remove_column :users, :likes_count
    remove_column :users, :dislikes_count

    remove_column :beers, :likes_count
    remove_column :beers, :dislikes_count
  end
end
