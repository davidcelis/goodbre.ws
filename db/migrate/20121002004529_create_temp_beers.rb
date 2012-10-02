class CreateTempBeers < ActiveRecord::Migration
  def change
    create_table :temp_beers do |t|
      t.references :brewery
      t.references :temp_brewery
      t.string :name
      t.float :abv
      t.references :style
      t.boolean :discontinued

      t.timestamps
    end
    add_index :temp_beers, :temp_brewery_id
    add_index :temp_beers, :style_id
  end
end
