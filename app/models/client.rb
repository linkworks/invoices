class Client < ActiveRecord::Base
  validates :name, :company_id, :presence => true
  validates :email, :format => { :with => /^([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4})?$/, :message => 'must be valid email.' }
  
  belongs_to :company
end
