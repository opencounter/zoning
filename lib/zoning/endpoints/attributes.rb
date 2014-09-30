module Zoning
	module Attributes
    prepend SearchParamsValidator

    ALLOWED_SEARCH_PARAMS = %i(use zone)
		def self.search(subdomain, locale, query={})
			key = 'attributes'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "attributes/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
