module Zoning
	module ZoneClearances

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zone_clearances/search.json", query_string)
			response = connection.get
			key = 'zone_clearances'
			Zoning::Connection.parse(response, key)
		end
	
	end
end