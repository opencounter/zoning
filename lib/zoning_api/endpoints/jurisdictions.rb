module ZoningAPI
	module Jurisdictions

		def self.find(id)
			key = 'jurisdiction'
			connection = ZoningAPI::Connection.connect(nil, :en, "jurisdictions/#{id}.json").get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.list(query={})
			key = 'jurisdictions'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(nil, :en, "jurisdictions.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.geojson(subdomain, parse: true)
			connection = ZoningAPI::Connection.connect(nil, :en, "jurisdictions/#{subdomain}.geojson").get
			if parse
				ZoningAPI::Connection.parse(connection)
			else
				ZoningAPI::Connection.verify(connection)
			end
		end

		def self.topojson(subdomain, parse: true)
			connection = ZoningAPI::Connection.connect(nil, :en, "jurisdictions/#{subdomain}.topojson").get
			if parse
				ZoningAPI::Connection.parse(connection)
			else
				ZoningAPI::Connection.verify(connection)
			end
		end

	end
end
