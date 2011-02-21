require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    login(:normal_user) # Shouldn't need to be admin for this
    
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    login(:normal_user)
    
    get :new
    assert_response :success
  end

  test "should create client" do
    login(:normal_user)
    
    assert_difference('Client.count') do
      post :create, :client => @client.attributes
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    login(:normal_user)
    
    get :show, :id => @client.to_param
    assert_response :success
  end

  test "should get edit" do
    login(:normal_user)
    
    get :edit, :id => @client.to_param
    assert_response :success
  end

  test "should update client" do
    login(:normal_user)
    
    put :update, :id => @client.to_param, :client => @client.attributes
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    login(:normal_user)
    
    assert_difference('Client.count', -1) do
      delete :destroy, :id => @client.to_param
    end

    assert_redirected_to clients_path
  end
end
