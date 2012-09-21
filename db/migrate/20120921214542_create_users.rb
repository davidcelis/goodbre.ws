class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :username,        :null => false
      t.string   :email,           :null => false
      t.string   :password_digest, :null => false
      t.string   :auth_token
      t.string   :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end

    add_index :users, :username, :unique => true
    add_index :users, :email, :unique => true
  end
end
