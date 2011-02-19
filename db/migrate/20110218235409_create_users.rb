class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :hashed_password, :null => false
      t.string :password_salt, :null => false
      t.string :type, :null => false
      t.integer :company_id, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
