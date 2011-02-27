require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  setup do
    @item = {
      :description => 'Vivamus luctus urna sed urna.',
      :unit_cost => 1_000,
      :quantity => 1,
      :discount => 0,
      :invoice_id => invoices(:one).id
    }
  end
  
  test "test invoice item should be valid" do
    assert Item.new(@item).valid?
  end
  
  # Return item with keys specified in exclude as nil
  def item_without(exclude)
    item = @item
    exclude.each do |e|
      item[e] = nil
    end
    
    item
  end
  
  # -----------------------------------------------------------------------------------
  
  test "should not create item without description" do
    assert Item.new(item_without [:description]).invalid?
  end
  
  test "should not create item without unit_cost" do
    assert Item.new(item_without [:unit_cost]).invalid?
  end
  
  test "should not create item without quantity" do
    assert Item.new(item_without [:quantity]).invalid?
  end
  
  test "should not accept quantity zero" do
    item = Item.new(@item)
    item.quantity = 0
    assert item.invalid?
  end
  
  test "should not accept negative unit_cost" do
    item = Item.new(@item)
    item.unit_cost = -10
    assert item.invalid?
  end
  
  test "should not accept discount bigger than 1 and less than zero" do
    item = Item.new(@item)
    item.discount = -1
    assert item.invalid?, "discount less than 0 should be invalid"
    
    item.discount = 10000
    assert item.invalid?, "#discount bigger than 100 should be invalid"
  end
  
  test "should not create item without invoice" do
    assert Item.new(item_without [:invoice_id]).invalid?
  end
  
  test "should return correct total_price" do
    item = Item.new(@item)
    assert_equal 1_000, item.total_price
    
    item.unit_cost = 10_000
    item.discount = 50 # In percentage!
    assert_equal 5_000, item.total_price
    
    item.quantity = 2
    assert_equal 10_000, item.total_price
    
    item.quantity = 1
    item.discount = 75
    assert_equal 2_500, item.total_price
    
    item = Item.new
    assert_equal 0, item.total_price
  end
end
