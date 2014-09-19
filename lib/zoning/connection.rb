require 'oauth2'

module Zoning
  class Connection

    def self.connect(subdomain, locale, path, query_string=nil)
      locale ||= Zoning.configuration.default_locale
      protocol = Zoning.configuration.protocol
      site_url = Zoning.configuration.site_url
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
      if response.try(:body).present?
        if response.status == 401
          "HTTP Token: Access denied."
        else
          begin
            parsed_response = Oj.load(response.body, bigdecimal_load: :float)
            if key.present?
              parsed_response[key]
            else
              parsed_response
            end
          rescue
            "Invalid json response"
          end
        end
      else
        "No response body"
      end
    end

    private

    def self.acc_token
      begin
        @acc_token ||= OAuth2::Client.new(
          Zoning.configuration.client_id,
          Zoning.configuration.client_secret,
          site: "#{Zoning.configuration.protocol}#{Zoning.configuration.site_url}",
          token_url: Zoning.configuration.token_path
        ).password.get_token(
          Zoning.configuration.username,
          Zoning.configuration.password
        ).token
      rescue Exception => e
        if e.respond_to?(:code) && e.respond_to?(:response)
          raise ConnectionFailedError.new(code: e.code, response: e.response)
        else
          raise ConnectionFailedError.new(code: 500, response: "Error: 500 Internal Server Error")
        end
      end
    end
  end
end
