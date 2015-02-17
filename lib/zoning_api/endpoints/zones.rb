module ZoningAPI
	module Zones

		def self.find(subdomain, locale, id)
			key = 'zone'
			connection = ZoningAPI::Connection.connect(subdomain, locale, "zones/#{id}.json").get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={})
			key = 'zones'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "zones.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

	end
end
