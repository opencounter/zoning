require 'oauth2'

module Zoning
  class Connection

    def self.connect(subdomain, locale, path, query_string=nil)
      locale ||= :en
      protocol = "https://"
      base_url = "zoning.io/#{locale.to_s}/api/1.0/"
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
      @acc_token ||= OAuth2::Client.new(
        ENV['ZONING_API_CLIENT_ID'],
        ENV['ZONING_API_CLIENT_SECRET'],
        site: "https://zoning.io/",
        token_url: "/admin/oauth/token"
      ).password.get_token(
        ENV['ZONING_API_CLIENT_USERNAME'],
        ENV['ZONING_API_CLIENT_PASSWORD']
      ).token
    end
  end
end
