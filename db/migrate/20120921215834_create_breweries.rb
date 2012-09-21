class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string  :name
      t.text    :description
      t.boolean :closed
      t.string  :permalink
      t.string  :website

      t.timestamps
    end

    add_index :breweries, :name
    add_index :breweries, :permalink
  end
end
