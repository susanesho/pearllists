require "codeclimate-test-reporter"
require "simplecov"
require "support/api_helpers"
require "factory_girl_rails"
CodeClimate::TestReporter.start
SimpleCov.start
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.include FactoryGirl::Syntax::Methods
  config.include ApiHelpers, type: :request
end
