require 'oauth2'

module Zoning
  class Connection

    def self.connect(subdomain = nil, locale = nil, path = nil, query_string=nil)
      raise ConfigurationError.new(:client_id) unless Zoning.configuration.client_id
      raise ConfigurationError.new(:client_secret) unless Zoning.configuration.client_secret

      locale ||= :en
      protocol = 'https://'
      site_url = 'zoning.us'
      base_url = "#{site_url}/#{locale.to_s}/api/1.0/"
      if subdomain
        absolute_url = "#{protocol}#{subdomain}.#{base_url}#{path}?#{query_string}"
      else
        absolute_url = "#{protocol}#{base_url}#{path}?#{query_string}"
      end

      Faraday.new(:url => absolute_url) do |builder|
        builder.request :oauth2, acc_token
        builder.adapter Faraday.default_adapter
      end
    end

    def self.parse(response, key=nil)
      if response.body
        if response.status == 401
          puts "Zoning API Error: 401 access denied."
          return nil
        else
          begin
            parsed_response = Oj.load(response.body, bigdecimal_load: :float)
            if key
              parsed_response.fetch(key)
            else
              parsed_response
            end
          rescue
            puts "Zoning API Error: invalid json response"
            puts response.body
            return nil
          end
        end
      else
        puts "Zoning API Error: no response body"
        return nil
      end
    end

    private

    def self.acc_token
      Zoning.configuration.access_token ||=
        begin
          OAuth2::Client.new(
            Zoning.configuration.client_id,
            Zoning.configuration.client_secret,
            site: "http://zoning.us/",
            token_url: "/admin/oauth/token"
          ).client_credentials.get_token.token
        rescue Exception => e
          if e.respond_to?(:code) && e.respond_to?(:response)
            raise ConnectionFailedError.new(code: e.code, response: e.response)
          else
            raise ConnectionFailedError.new(code: 500, response: "Internal Server Error.")
          end
        end
    end
  end
end
