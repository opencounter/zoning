module ZoningAPI
	module Geo

		# Geo.geocode takes the folling, required params:
		# :address, String

		def self.geocode(subdomain, query={})
			key = 'addresses'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, :en, "geocode.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end
	end
end
