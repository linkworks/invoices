class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.text :description
      t.decimal :unit_cost, :precision => 11, :scale => 2 # Big numbers with just two decimal places
      t.integer :quantity
      t.decimal :discount, :precision => 3, :scale => 2 # 1.0, 0.5, etc.
      t.integer :invoice_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
