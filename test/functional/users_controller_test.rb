require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @submit_user = {
      :email => 'functional@test.org',
      :password => 'password',
      :password_confirmation => 'password',
      :user_type => 'admin',
      :company_id => companies(:one).id
    }
    
    @edit_user = User.create!(@submit_user) # The "!" is so that this test exits if this fails.
    @edit_user.password = nil
    @edit_user.password_confirmation = nil
    @edit_user.user_type = 'user'
  end

  test "should get index" do
    # User should be logged in and be admin
    login(:admin_user)
    
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  # FIXME: This test is weird, ApplicationController::blackhole is not redirecting to 404. This test shouldn't pass, but it does.
  test "should not get index if user not admin" do
    login(:normal_user)
    
    get :index
    assert_redirected_to show_login_path
  end

  test "should get new only if there are companies in db" do
    login(:admin_user)
    
    assert !Company.all.empty?, "There should be companies in db to execute this test"
    get :new
    assert_response :success
  end

  test "should create user" do
    # Must be admin for this
    login(:admin_user)
    
    assert_difference('User.count') do
      @submit_user['email'] = 'changed@functional-test.org' # Needs this change because email is unique
      post :create, :user => @submit_user
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    login(:admin_user)
    
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    login(:admin_user)
    
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    login(:admin_user)
    
    put :update, :id => @edit_user.to_param, :user => @edit_user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    login(:admin_user)
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
  
  test "should not sign up if logged in" do
    login(:normal_user)
    get :sign_up
    assert_redirected_to invoices_path
  end
  
  test "should get sign up" do
    logout # Make sure we are not logged in
    
    get :sign_up
    assert_response :success
  end
  
  test "should sign up" do
    logout
    
    post :public_create, :email => 'functional1234@signup.com', :password => 'password', :password_confirmation => 'password', :company_name => 'Company', :company_address => 'Address'
    assert_redirected_to show_login_path
  end
end
