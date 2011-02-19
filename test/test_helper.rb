ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  setup do
    @valid_emails = %w{email@example.org email@example.com email@with.subdomain.com email.with.dots@example.com emailwith+plus@domain.cl email.withdots+andplus@example.com}
    @invalid_emails = %w{@example.com justaword domain.com  commas,yeah@email.org something@}
  end
end
