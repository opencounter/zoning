module Zoning
	module Geo

		# Geo.geocode takes the folling, required params:
		# :address, String

		def self.geocode(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "geocode.json", query_string)
			response = connection.get
			key = 'addresses'
			Zoning::Connection.parse(response, key)
		end
	end
end