require_relative '../lib/zoning'
Dir[__dir__ + '/support/**/*.rb'].each { |f| require f }

require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: false)

RSpec.configure do |config|
  config.order = "random"
  config.tty = true
  config.mock_with :flexmock
  config.include SetupHelpers
end
