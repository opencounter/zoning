require_relative '../lib/zoning_api'
Dir[__dir__ + '/support/**/*.rb'].each { |f| require f }

require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: false)

RSpec.configure do |config|
  config.order = "random"
  config.tty = true
  config.mock_with :flexmock
  config.include SetupHelpers
  config.before(:each) do
    WebMock.reset!
    SetupHelpers.unconfigure_zoning
  end
end
