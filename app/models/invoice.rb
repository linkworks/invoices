class Invoice < ActiveRecord::Base
  validates :client_id, :presence => true
  validates :status, :inclusion => { :in => ['draft', 'sent', 'paid'] }
  
  belongs_to :client
end
