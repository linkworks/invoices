class Invoice < ActiveRecord::Base
  # TODO: Add tax info to invoice
  
  validates :client_id, :presence => true
  validates :status, :inclusion => { :in => ['draft', 'sent', 'paid'] }
  
  #validate :at_least_one_item
  
  belongs_to :client
  has_many :items
  accepts_nested_attributes_for :items, :allow_destroy => true
  
  def at_least_one_item
    self.errors.add(:items, "Invoice should have at least one item.") if self.items.empty?
  end
  
  def total  
    @total = 0
    self.items.each do |item|
      @total += item.total_price
    end
    
    @total
  end
  
  def validate_client_belongs_to(user)
    unless user.company.clients.find(self.client_id)
      self.errors.add(:client_id, "That client is not yours!") 
      false
    else
      true
    end
  rescue ActiveRecord::RecordNotFound
    false
  end
end
