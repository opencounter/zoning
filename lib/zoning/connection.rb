module Zoning
	class Connection

		def self.connect(subdomain, locale, path, query_string=nil)
			if locale.blank?
				locale = "en"
			else
				locale = locale.to_s
			end
			protocol = "https://"
			base_url = "zoning.io/#{locale}/api/1.0/"
			if query_string.present?
				conn = Faraday.new(:url => "#{protocol}#{subdomain}.#{base_url}#{path}?#{query_string}")
			else
				conn = Faraday.new(:url => "#{protocol}#{subdomain}.#{base_url}#{path}")
			end
			conn.token_auth(ENV['ZONING_API_TOKEN'])
			conn
		end

		def self.parse(response, key=nil)
			if response.try(:body).present?
				if response.body == "HTTP Token: Access denied.\n"
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
	end
end