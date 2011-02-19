class Invoice < ActiveRecord::Base
  validates :client_id, :presence => true
  validates :status, :inclusion => { :in => ['draft', 'sent', 'paid'] }
  
  validate :at_least_one_item
  
  belongs_to :client
  has_many :items
  
  def at_least_one_item
    self.errors.add(:items, "Invoice should have at least one item.") if self.items.empty?
  end
end
