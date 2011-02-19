require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  setup do
    @client = {
      :name => 'Client\'s Name',
      :email => 'client@company.org',
      :address => '124 Drive Avenue',
      :company_name => 'Incorporation Corp. Inc.',
      :company_id => companies(:one).id
    }
  end
  
  # Return client with keys specified in exclude as nil
  def client_without(exclude)
    client = @client
    exclude.each do |e|
      client[e] = nil
    end
    
    client
  end
  
  # -----------------------------------------------------------------------------------
  
  test "should not create client without name" do
    assert Client.new(client_without [:name]).invalid?
  end
  
  test "should not create client without company_id" do
    assert Client.new(client_without [:company_id]).invalid?
  end
  
  test "should let create client without email address" do
    assert Client.new(client_without [:email]).valid?
  end
  
  test "should not allow invalid email addresses" do
    client = Client.new(@client)
    
    @valid_emails.each do |email|
      client.email = email
      assert client.valid?, "#{email} should be valid"
    end
    
    @invalid_emails.each do |email|
      client.email = email
      assert client.invalid?, "#{email} should be invalid"
    end
  end
end
