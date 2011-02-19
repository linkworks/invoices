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
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      @submit_user['email'] = 'changed@functional-test.org' # Needs this change because email is unique
      post :create, :user => @submit_user
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @edit_user.to_param, :user => @edit_user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
