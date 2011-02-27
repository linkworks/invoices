class ChangeTypeOfColumnOfDiscountToInteger < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.change :discount, :integer
    end
  end

  def self.down
    change_table :items do |t|
      t.change :discount, :float, :precision => 3,  :scale => 2
    end
  end
end
