module Zoning
	module PermissionTypes
    prepend SearchParamsValidator

    ALLOWED_SEARCH_PARAMS = %i(id code name description type)

		def self.list(subdomain, locale, query={})
			key = 'permission_types'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "permission_types.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
