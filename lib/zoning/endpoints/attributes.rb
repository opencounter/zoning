module Zoning
	module Attributes

		def self.search(subdomain, locale, query={})
			key = 'attributes'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "attributes/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
