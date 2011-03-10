require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    login(:normal_user)
    
    get :index
    #assert_response :success
    assert_response :missing # This view is disabled for now
    #assert_not_nil assigns(:companies)
  end

  test "should get new" do
    login(:normal_user)
    
    get :new
    #assert_response :success
    assert_response :missing # This view is disabled for now
  end

  #test "should create company" do
  #  login(:normal_user)
  #  
  #  assert_difference('Company.count') do
  #    post :create, :company => @company.attributes
  #  end
  #
  #  assert_redirected_to company_path(assigns(:company))
  #end

  test "should show company" do
    login(:normal_user)
    
    get :show, :id => @company.to_param
    #assert_response :success
    assert_response :missing # This view is disabled for now
  end

  test "should get edit" do
    login(:normal_user)
    
    get :edit, :id => users(:normal_user).company.to_param
    assert_response :success
  end
  
  test "should not get another user's edit company form" do
    login(:acme)
    
    get :edit, :id => users(:normal_user).company.to_param
    assert_response :missing
  end

  test "should update company" do
    login(:normal_user)
    
    put :update, :id => users(:normal_user).company.to_param, :company => users(:normal_user).company.attributes
    assert_redirected_to edit_company_path(assigns(:company))
  end
  
  test "should not update another user's company" do
    login(:acme)
    
    put :update, :id => users(:normal_user).company.to_param, :company => users(:normal_user).company.attributes
    assert_response :missing
  end

  #test "should destroy company" do
  #  login(:normal_user)
  #  
  #  assert_difference('Company.count', -1) do
  #    delete :destroy, :id => @company.to_param
  #  end
  #
  #  assert_redirected_to companies_path
  #end
end
