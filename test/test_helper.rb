require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end


#setup capybara for integration tests here
class TinyEarl::IntegrationTest < ActionDispatch::IntegrationTest
  # include Capybara::Screenshot::MiniTestPlugin
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions
  Capybara.default_driver = :poltergeist
  Capybara.server_port = 55_153
  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def wait_for_ajax
    loop until page.evaluate_script('jQuery.active').zero?
  end
end
