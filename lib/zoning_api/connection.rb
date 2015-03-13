require 'oauth2'

module ZoningAPI
  class Connection

    def self.connect(subdomain = nil, locale = nil, path = nil, query_string=nil)
      raise ConfigurationError.new(:client_id) unless ZoningAPI.configuration.client_id
      raise ConfigurationError.new(:client_secret) unless ZoningAPI.configuration.client_secret

      locale ||= :en
      protocol = 'http://'
      domain = ZoningAPI.configuration.domain || 'zoning.io'
      base_url = "#{domain}/#{locale.to_s}/api/1.0/"
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
      body = self.verify(response)
      if body
        begin
          parsed_response = Oj.load(body, bigdecimal_load: :float)
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
    end

    def self.verify(response)
      if response.body
        if response.status == 401
          puts "Zoning API Error: 401 access denied."
          return nil
        else
          return self.body(response)
        end
      else
        puts "Zoning API Error: no response body"
        return nil
      end
    end

    private

    def self.acc_token
      ZoningAPI.configuration.access_token ||=
        begin
          OAuth2::Client.new(
            ZoningAPI.configuration.client_id,
            ZoningAPI.configuration.client_secret,
            site: "http://#{ZoningAPI.configuration.domain || 'zoning.io'}/",
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

    # All this encoding stuff is adapted from HTTParty.
    # Net::HTTP and Faraday have broken character encoding, so fix it :\
    def self.body(response)
      if response.body
        charset = get_charset(response)

        if charset.nil?
          return response.body
        end

        if "utf-16".casecmp(charset) == 0
          encode_utf_16(response.body)
        else
          begin
            encoding = Encoding.find(charset)
            response.body.force_encoding(encoding)
          rescue
            response.body
          end
        end
      end
    end

    def self.get_charset(response)
      content_type = response.headers["content-type"]
      if content_type.nil?
        return nil
      end

      if content_type =~ /;\s*charset\s*=\s*([^=,;"\s]+)/i
        return $1
      end

      if content_type =~ /;\s*charset\s*=\s*"((\\.|[^\\"])+)"/i
        return $1.gsub(/\\(.)/, '\1')
      end

      nil
    end

    def self.encode_utf_16(body)
      if body.bytesize >= 2
        if body.getbyte(0) == 0xFF && body.getbyte(1) == 0xFE
          return body.force_encoding("UTF-16LE")
        elsif body.getbyte(0) == 0xFE && body.getbyte(1) == 0xFF
          return body.force_encoding("UTF-16BE")
        end
      end

      # No good indicators. Make an assumption.
      body.force_encoding("UTF-16BE")
    end


  end
end
