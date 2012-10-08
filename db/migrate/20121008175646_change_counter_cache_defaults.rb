class ChangeCounterCacheDefaults < ActiveRecord::Migration
  def up
    change_column :users, :likes_count, :integer, :default => 0
    change_column :users, :dislikes_count, :integer, :default => 0
    change_column :beers, :likes_count, :integer, :default => 0
    change_column :beers, :dislikes_count, :integer, :default => 0

    User.pluck(:id).each { |id| User.reset_counters(id, :likes, :dislikes) }
    Beer.pluck(:id).each { |id| Beer.reset_counters(id, :recommendable_likes, :recommendable_dislikes) }
  end

  def down
    change_column :users, :likes_count, :integer, :default => 0
    change_column :users, :dislikes_count, :integer, :default => 0
    change_column :beers, :likes_count, :integer, :default => 0
    change_column :beers, :dislikes_count, :integer, :default => 0
  end
end
