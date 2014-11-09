module Zoning
	module Uses
    prepend SearchParamsValidator

		def self.find(subdomain, locale, id)
			key = 'use'
			connection = Zoning::Connection.connect(subdomain, locale, "uses/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

    ALLOWED_SEARCH_PARAMS = %i(id slug name category_name sub_category_name full_name description featured)

		def self.list(subdomain, locale, query={})
			key = 'uses'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "uses.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.search(subdomain, locale, keywords)
			key = 'uses'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: keywords}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "uses/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end

end
