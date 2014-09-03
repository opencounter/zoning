module Zoning
	module Attributes

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "attributes/search.json", query_string).get
			Zoning::Connection.parse(connection)
		end
		
	end
end