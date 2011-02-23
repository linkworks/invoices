require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should login" do
    post :create, :email => users(:one).email, :password => 'password'
    assert_response :redirect
  end
  
  test "should login with remember" do
    post :create, :email => users(:one).email, :password => 'password', :remember_me => true
    assert_response :redirect
    assert_equal users(:one).id, cookies.signed['remember_id']
    assert_equal users(:one).remember_key, cookies['remember_key']
  end
  
  test "should not login" do
    post :create, :email => users(:one).email, :password => 'notthisone!'
    assert_response :success
    assert_select '#login_error' # This element should be present
    
    # Without password
    post :create, :email => users(:one).email, :password => ''
    assert_response :success
    assert_select '#login_error' # This element should be present
    
    # Without any data
    post :create, :email => '', :password => ''
    assert_response :success
    assert_select '#login_error' # This element should be present
  end
  
  test "should logout" do
    # Log a user in first
    session[:user_id] = users(:one).id
    
    delete :destroy
    assert_redirected_to show_login_path
    assert_not_equal users(:one).id, cookies.signed[:remember_id]
    assert_not_equal users(:one).remember_key, cookies.signed[:remember_key] 
  end
  
end
