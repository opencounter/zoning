module Zoning
	module Clearance
    prepend SearchParamsValidator

    ALLOWED_SEARCH_PARAMS = %i(id zone use permission parameters)
		def self.query(subdomain, locale, query={})
			key = 'clearance'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "clearance.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
