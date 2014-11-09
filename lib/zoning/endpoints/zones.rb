module Zoning
	module Zones
    prepend SearchParamsValidator

		ALLOWED_SEARCH_PARAMS = %i(id slug code name description latitude longitude overlay)

		def self.find(subdomain, locale, id)
			key = 'zone'
			connection = Zoning::Connection.connect(subdomain, locale, "zones/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={})
			key = 'zones'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zones.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.search(subdomain, locale, keywords)
			key = 'zones'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: keywords}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zones/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
