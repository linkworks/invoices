require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not create user without email" do
    user = User.new(:password => 'password', :password_confirmation => 'password', :user_type => 'admin')
    assert user.invalid?
  end
  
  test "should not create user without password" do
    user = User.new(:email => 'test@example.org', :user_type => 'admin')
    assert user.invalid?
    
    user.password_confirmation = 'password'
    assert user.invalid?
  end
  
  test "should not create user without password confirmation" do
    # FIXME: I have no idea why this test does not pass.
    user = User.new(:email => 'test@example.org', :user_type => 'admin', :password => 'password')
    assert user.invalid?
  end
  
  test "should not create user without correct password confirmation" do
    user = User.new(:email => 'test@example.org', :user_type => 'admin', :password => 'password', :password_confirmation => 'different')
    assert user.invalid?, "incorrect password confirmation should invalidate user model"
    
    user = User.new(:email => 'test@example.org', :user_type => 'admin', :password => 'password', :password_confirmation => 'password')
    assert user.valid?, "correct password confirmation should validate model"
  end
  
  test "should not accept user user_type different from existings" do
    user_types = ['admin', 'user']
    invalids = %w{ superuser root administrator }
    user = User.new(:email => 'test@example.org', :password => 'password', :password_confirmation => 'password')
    
    user_types.each do |user_type|
      user.user_type = user_type
      assert user.valid?, "#{user_type} should be valid"
    end
    
    invalids.each do |user_type|
      user.user_type = user_type
      assert user.invalid?, "#{user_type} should be invalid"
    end
  end
  
  test "should not create user without valid email" do
    user = User.new(:user_type => 'admin', :password => 'password', :password_confirmation => 'password')
    
    valid_emails = %w{email@example.org email@example.com email@with.subdomain.com email.with.dots@example.com emailwith+plus@domain.cl email.withdots+andplus@example.com}
    invalid_emails = %w{@example.com justaword domain.com  commas,yeah@email.org something@}
    
    valid_emails.each do |email|
      user.email = email
      assert user.valid?, "#{email} should be valid"
    end
    
    invalid_emails.each do |email|
      user.email = email
      assert user.invalid?, "#{email} should be invalid"
    end
  end
end
