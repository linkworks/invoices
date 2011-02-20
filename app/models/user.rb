require 'digest/sha2'

class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, :message => 'must be valid email'
  validates :password, :confirmation => true
  validates :user_type, :presence => true, :inclusion => { :in => ['admin', 'user'] }
  validates :company_id, :presence => true
  
  belongs_to :company
  
  attr_accessor :password_confirmation 
  attr_reader :password
  
  validate :password_must_be_present
  
  class << self 
    def authenticate(email, password)
      if user = find_by_email(email) 
        if user.hashed_password == encrypt_password(password, user.password_salt)
          user
        end 
      end
    end
    
    def encrypt_password(password, password_salt) 
      Digest::SHA2.hexdigest(password + "cb093478n0f3smh" + password_salt) # Something random
    end 
  end
  
  # 'password' is a virtual attribute
  def password=(password) 
    @password = password
    
    if password.present? 
      generate_password_salt 
      
      self.hashed_password = self.class.encrypt_password(password, password_salt)
    end 
  end
  
  def admin?
    user_type == 'admin'
  end

  private
    def password_must_be_present 
      errors.add(:password, "is missing") unless hashed_password.present?
    end

    def generate_password_salt 
      self.password_salt = self.object_id.to_s + rand.to_s
    end
end
