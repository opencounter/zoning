module Zoning
	module ZoneClearances

		def self.search(subdomain, locale, query={})
			key = 'zone_clearances'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zone_clearances/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end
	
	end
end