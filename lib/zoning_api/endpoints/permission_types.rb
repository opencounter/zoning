module ZoningAPI
	module PermissionTypes

		def self.list(subdomain, locale, query={})
			key = 'permission_types'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "permission_types.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

	end
end
