module Zoning
	module Permissions
    prepend SearchParamsValidator

    ALLOWED_SEARCH_PARAMS = %i(id code name description type)
		def self.query(subdomain, locale, query={})
			key = 'permissions'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "permissions/query.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale)
			key = 'permissions'
			connection = Zoning::Connection.connect(subdomain, locale, "permissions.json").get
			Zoning::Connection.parse(connection, key)
		end
	end
end
