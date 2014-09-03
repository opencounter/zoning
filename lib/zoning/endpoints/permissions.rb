module Zoning
	module Permissions

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "permissions/search.json", query_string)
			response = connection.get
			key = 'permissions'
			Zoning::Connection.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = Zoning::Connection.connect(subdomain, locale, "permissions.json")
			response = connection.get
			key = 'permissions'
			Zoning::Connection.parse(response, key)
		end
	
	end
end