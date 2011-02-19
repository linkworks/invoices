class ChangeNameOfTypeColumn < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.column :user_type, :string
      t.remove :type
    end
  end

  def self.down
    t.column :type, :string
    t.remove :user_type
  end
end
