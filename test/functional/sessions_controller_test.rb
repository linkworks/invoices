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
  end
  
end
