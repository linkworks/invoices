class Item < ActiveRecord::Base
  validates :description, :quantity, :unit_cost, :presence => true
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :discount, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :invoice_id, :presence => true, :unless => :nested
  attr_accessor :nested
  
  belongs_to :invoice
  
  def total_price
    self.unit_cost * self.quantity * ((100 - self.discount) / 100.0)
  rescue NoMethodError => method
    0
  end
end
