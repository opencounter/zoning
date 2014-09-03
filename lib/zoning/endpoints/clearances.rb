module Zoning
	module Clearances
		
		def self.find(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "clearance.json", query_string)
			response = connection.get
			key = 'clearance'
			Zoning::Connection.parse(response, key)
		end
	
	end
end
