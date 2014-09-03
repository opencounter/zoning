module Zoning
	module Geo

		# Geo.geocode takes the folling, required params:
		# :address, String

		def self.geocode(subdomain, locale, query={})
			key = 'addresses'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "geocode.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end
	end
end