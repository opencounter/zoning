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

		def self.geojson(subdomain, parse: true)
			connection = Zoning::Connection.connect(nil, :en, "jurisdictions/#{subdomain}.geojson").get
			if parse
				Zoning::Connection.parse(connection)
			else
				Zoning::Connection.verify(connection)
			end
		end

	end
end
