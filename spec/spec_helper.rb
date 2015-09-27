require 'simplecov'
require 'vcr_setup'
require 'webmock'
require 'helpers'
SimpleCov.start

RSpec.configure do |config|
  include Helpers

  config.backtrace_exclusion_patterns << %r{/gems/}

  # http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # reset OmniAuth to a consistent state
  config.before(:each) do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
