ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def sign_in(user, password)
    post login_path, params: {session: {email: user.email, password: password}}
  end

  def create_admin
    User.create(username: "jon", email: "jon@gmail.com",
      password: "password", admin: true)
  end
end
