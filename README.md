# Zoning

Ruby wrapper for the Zoning.io API.

## Configuration

In order to interact with the Zoning gem, please set your API token in an initializer:

**These fields are required.**

    # config/initializers/zoning_api.rb
    Zoning.configure do |config|
      config.client_id = ENV['ZONING_API_CLIENT_ID']
      config.client_secret = ENV['ZONING_API_CLIENT_SECRET']
      config.username = ENV['ZONING_API_USERNAME']
      config.password = ENV['ZONING_API_PASSWORD']
    end
