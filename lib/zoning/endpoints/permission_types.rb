module Zoning
	module PermissionTypes

		def self.list(subdomain, locale, query={})
			key = 'permission_types'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "permission_types.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
