module Zoning
	module Clearances

		def self.search(subdomain, locale, query={})
			key = 'clearance'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "clearance.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
