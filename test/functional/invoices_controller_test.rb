require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:one)
    
    @invoice_with_items = invoices(:one).attributes
    @invoice_with_items[:items_attributes] = {
      1 => {
        :description => "Lorem Ipsum",
        :unit_cost => 1_000,
        :quantity => 1,
        :discount => 0,
        :nested => 'true'
      }
    }
    
    @invoice_with_incorrect = {
      :client_id => clients(:acme).id,
      :status => 'draft'
    }
  end

  test "should get index" do
    login(:normal_user)
    
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    login(:normal_user)
    
    get :new
    assert_response :success
  end

  test "should create invoice" do
    login(:normal_user)
    
    assert_difference('Invoice.count') do
      post :create, :invoice => @invoice_with_items
    end

    assert_redirected_to invoice_path(assigns(:invoice))
  end
  
  test "should not create invoice with invalid client_id for current user" do
    login(:normal_user)
    
    assert_difference('Invoice.count', 0) do
      post :create, :invoice => @invoice_with_incorrect
    end
    
    assert_response :success
  end

  test "should show invoice" do
    login(:normal_user)
    
    get :show, :id => @invoice.to_param
    assert_response :success
  end

  test "should get edit" do
    login(:normal_user)
    
    get :edit, :id => @invoice.to_param
    assert_response :success
  end

  test "should update invoice" do
    login(:normal_user)
    
    put :update, :id => @invoice.to_param, :invoice => @invoice.attributes
    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should destroy invoice" do
    login(:normal_user)
    
    assert_difference('Invoice.count', -1) do
      delete :destroy, :id => @invoice.to_param
    end

    assert_redirected_to invoices_path
  end
end
