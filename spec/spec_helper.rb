require_relative '../lib/zoning_api'
Dir[__dir__ + '/support/**/*.rb'].each { |f| require f }

require 'webmock/rspec'
WebMock.allow_net_connect!

RSpec.configure do |config|
  config.order = "random"
  config.tty = true
  config.mock_with :flexmock
  config.include SetupHelpers
end
