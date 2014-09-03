# Zoning

Ruby wrapper for the Zoning.io API.

## Configuration

In order to interact with the Zoning, please specify the auth token in an initializer:

**These fields are required.**

    # config/initializers/zoning_api.rb
    Zoning.configure do |config|
    	config.api_token = ENV['ZONING_API_TOKEN']
    end