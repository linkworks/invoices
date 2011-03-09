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
    assert_select 'input#client_company_id[value=?]', /#{users(:normal_user).company.id}/ # This will validate that the hidden company_id is valid, though it doesn't matter really
  end

  test "should create client" do
    login(:normal_user)
    
    assert_difference('Client.count') do
      post :create, :client => @client.attributes
    end
    
    assert_equal users(:normal_user).company.id, @client.company.id # Validate that the company_id wasn't tampered with

    #assert_redirected_to client_path(assigns(:client))
    assert_redirected_to clients_path
  end
  
  test "should create client even if company_id was tampered with" do
    login(:normal_user)
    
    # Modify client
    client = @client.attributes
    client[:company_id] = 4736258 # Somethin mega-random
    
    assert_difference("Client.count") do
      post :create, :client => client
    end
    
    assert_equal users(:normal_user).company.id, @client.company.id # Validate that the company_id wasn't tampered with
    #assert_redirected_to client_path(assigns(:client))
    assert_redirected_to clients_path
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

    assert_equal users(:normal_user).company.id, @client.company.id # Validate that the company_id wasn't tampered with

    #assert_redirected_to client_path(assigns(:client))
    assert_redirected_to clients_path
  end
  
  test "should update client even if company_id was tampered with" do
    login(:normal_user)
    
    # Modify client
    client = @client.attributes
    client[:company_id] = 4736258 # Somethin mega-random
    
    put :update, :id => @client.to_param, :client => client
    
    assert_equal users(:normal_user).company.id, @client.company.id # Validate that the company_id wasn't tampered with
    #assert_redirected_to client_path(assigns(:client))
    assert_redirected_to clients_path
  end

  test "should destroy client" do
    login(:normal_user)
    
    assert_difference('Client.count', -1) do
      delete :destroy, :id => @client.to_param
    end

    assert_redirected_to clients_path
  end
end
