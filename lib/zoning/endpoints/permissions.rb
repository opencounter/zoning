module Zoning
	module Permissions
    prepend SearchParamsValidator

    ALLOWED_SEARCH_PARAMS = %i(id code name description keywords type)
		def self.search(subdomain, locale, query={})
			key = 'permissions'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "permissions/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale)
			key = 'permissions'
			connection = Zoning::Connection.connect(subdomain, locale, "permissions.json").get
			Zoning::Connection.parse(connection, key)
		end
	end
end
