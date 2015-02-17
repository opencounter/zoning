module ZoningAPI
	module LandUses

		def self.find(subdomain, locale, id)
			key = 'land_use'
			connection = ZoningAPI::Connection.connect(subdomain, locale, "land_uses/#{id}.json").get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={})
			key = 'land_uses'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "land_uses.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

	end

end
