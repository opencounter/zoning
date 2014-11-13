module Zoning
	module Jurisdictions

		def self.find(id)
			key = 'jurisdiction'
			connection = Zoning::Connection.connect(nil, :en, "jurisdictions/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(query={})
			key = 'jurisdictions'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = Zoning::Connection.connect(nil, :en, "jurisdictions.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.geojson(subdomain)
			base_url = "http://d2ks5jj5byfwun.cloudfront.net/geojson/"
			# base_url = "http://zoning-api.s3.amazonaws.com/geojson/"
			connection = Faraday.new(:url => "#{base_url}#{subdomain}.geojson").get
			if connection.try(:body).present?
				begin
					Oj.load(connection.body, bigdecimal_load: :float).to_json
				rescue
					puts "Zoning API Error: invalid json response"
					return nil
				end
			else
				puts "Zoning API Error: no response body"
				return nil
			end
		end

	end
end
