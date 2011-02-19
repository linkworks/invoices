class Item < ActiveRecord::Base
  validates :description, :quantity, :unit_cost, :presence => true
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :discount, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1}
  validates :invoice_id, :presence => true
  
  belongs_to :invoice
  
  def total_price
    unit_cost * quantity * (1 - discount)
  end
end
