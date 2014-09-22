# Zoning

Ruby wrapper for the Zoning.io API.

## Configuration

Access to the Zoning.io API is controlled by OAuth2.

In order to interact with the Zoning gem, please set your API credentials (App
ID and App Secret) in an initializer:

**These fields are required.**

    # config/initializers/zoning_api.rb
    Zoning.configure do |config|
      config.client_id = ENV['ZONING_API_CLIENT_ID']
      config.client_secret = ENV['ZONING_API_CLIENT_SECRET']
    end

This will authenticate to the Zoning.io API using the [client credentials
flow](http://tools.ietf.org/html/rfc6749#section-4.4):

    +----------+                                  +---------------+
    |          |                                  |               |
    |          |>--(A)- Client Authentication --->|   Zoning.io   |
    | Your App |                                  |      API      |
    |          |<--(B)---- Access Token ---------<|               |
    |          |                                  |               |
    +----------+                                  +---------------+
