class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.string :permalink

      t.timestamps
    end

    add_index :styles, :permalink
  end
end
