module Zoning
	class Connection

		def self.connect(subdomain, locale, path, query_string=nil)
			locale ||= :en
			protocol = "http://"
			base_url = "zoning.us/#{locale.to_s}/api/1.0/"
			if subdomain.present?
				conn = Faraday.new(:url => "#{protocol}#{subdomain}.#{base_url}#{path}?#{query_string}")
			else
				conn = Faraday.new(:url => "#{protocol}#{base_url}#{path}?#{query_string}")
			end
			conn.token_auth(Zoning.configuration.api_token)
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
