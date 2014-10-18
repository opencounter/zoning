module Zoning
	module ZoneClearances
    prepend SearchParamsValidator

    ALLOWED_SEARCH_PARAMS = %i(zone use permission parameters)
		def self.where(subdomain, locale, query={})
			key = 'zone_clearances'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zone_clearances/where.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
