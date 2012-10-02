class CreateTempBreweries < ActiveRecord::Migration
  def change
    create_table :temp_breweries do |t|
      t.string :name
      t.boolean :closed
      t.string :website

      t.timestamps
    end
  end
end
