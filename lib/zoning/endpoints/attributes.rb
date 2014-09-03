module Zoning
	module Attributes

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "attributes/search.json", query_string)
			response = connection.get
			Zoning::Connection.parse(response)
		end
		
	end
end