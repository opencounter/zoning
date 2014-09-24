module Zoning
	module Zones
    prepend SearchParamsValidator

		def self.find(subdomain, locale, id)
			key = 'zone'
			connection = Zoning::Connection.connect(subdomain, locale, "zones/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale)
			key = 'zones'
			connection = Zoning::Connection.connect(subdomain, locale, "zones.json").get
			Zoning::Connection.parse(connection, key)
		end

    ALLOWED_SEARCH_PARAMS = %i(id overlay category_id name code description latitude longitude radius keywords)
		def self.search(subdomain, locale, query={})
			key = 'zones'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zones/search.json", query_string).get
			Zoning::Connection.parse(connection, key)

		end
	end
end
