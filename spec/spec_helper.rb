require 'dummy_app/init'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'database_cleaner'
require 'devise-two-factor-meat'
require 'devise/version'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.order = :random
  config.infer_spec_type_from_file_location!

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def login_button
  if Devise::VERSION.to_f < 3.3
    'Sign in'
  else
    'Log in'
  end
end
