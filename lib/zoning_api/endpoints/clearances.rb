module ZoningAPI
	module Clearances

		def self.list(subdomain, locale, query={})
			key = 'clearances'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "clearances.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.find(subdomain, locale, query={})
			key = 'clearance'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "clearances/find.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

	end
end
