module Zoning
	module LandUseConditions

		def self.find(subdomain, locale, id)
			key = 'land_use_condition'
			connection = Zoning::Connection.connect(subdomain, locale, "land_use_conditions/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={})
			key = 'land_use_conditions'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "land_use_conditions.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end