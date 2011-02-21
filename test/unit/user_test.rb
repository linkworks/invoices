require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = {
      :email => 'unit@testcase.org',
      :password => 'passw0rd',
      :password_confirmation => 'passw0rd',
      :user_type => 'admin',
      :company_id => companies(:one).id
    }
  end
  
  # Return user with keys specified in exclude as nil
  def user_without(exclude)
    user = @user
    exclude.each do |e|
      user[e] = nil
    end
    
    user
  end
  
  test "should not create user without email" do
    user = User.new(user_without [:email])
    assert user.invalid?
  end
  
  test "should not create duplicate user with same email" do
    user = User.create(@user)
    user_2 = User.new(@user)
    assert user_2.invalid?
  end
  
  test "should not create user without password" do
    user = User.new(user_without [:password, :password_confirmation])
    assert user.invalid?
    
    user.password_confirmation = 'password'
    assert user.invalid?
  end
  
  test "should not create user without password confirmation" do
    user = User.new(@user)
    user.password_confirmation = ''
    assert user.invalid?
  end
  
  test "should not create user without correct password confirmation" do
    user_params = @user
    user = User.new(user_params)
    assert user.valid?, "correct password confirmation should validate model"
  
    user_params[:password_confirmation] = 'different'
    user = User.new(user_params)
    assert user.invalid?, "incorrect password confirmation should invalidate user model"
  end
  
  test "should not accept user user_type different from existings" do
    user_types = ['admin', 'user']
    invalids = %w{ superuser root administrator }
    user = User.new(user_without [:user_type])
    
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
    user = User.new(@user)
    
    @valid_emails.each do |email|
      user.email = email
      assert user.valid?, "#{email} should be valid"
    end
    
    @invalid_emails.each do |email|
      user.email = email
      assert user.invalid?, "#{email} should be invalid"
    end
  end
end
