require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    # Valid company params
    @company = {
      :name => 'Acme Inc.',
      :address => '1 Acme Drive'
    }
  end
  
  test "should not create company without name" do
    company = @company
    company[:name] = nil
    c = Company.new(company)
    assert c.invalid?
  end
end
