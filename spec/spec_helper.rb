require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require_relative '../lib/zoning'

RSpec.configure do |config|
  config.order = "random"
  config.tty = true
  config.mock_with :flexmock
end
