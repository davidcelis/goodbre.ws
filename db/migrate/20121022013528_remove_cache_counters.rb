class RemoveCacheCounters < ActiveRecord::Migration
  def up
    remove_column :users, :likes_count
    remove_column :users, :dislikes_count

    remove_column :beers, :likes_count
    remove_column :beers, :dislikes_count
  end

  def down
    add_column :users, :likes_count, :integer
    add_column :users, :dislikes_count, :integer

    add_column :beers, :likes_count, :integer
    add_column :beers, :dislikes_count, :integer
  end
end
