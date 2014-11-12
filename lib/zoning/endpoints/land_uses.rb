module Zoning
	module LandUses

		def self.find(subdomain, locale, id)
			key = 'land_use'
			connection = Zoning::Connection.connect(subdomain, locale, "land_uses/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={})
			key = 'land_uses'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "land_uses.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.search(subdomain, locale, keywords)
			key = 'land_uses'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: keywords}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "land_uses/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end

end
