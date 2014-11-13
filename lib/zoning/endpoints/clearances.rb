module Zoning
	module Clearances

		def self.list(subdomain, locale, query={})
			key = 'clearances'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "clearances.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.calculate(subdomain, locale, query={})
			key = 'clearance'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(subdomain, locale, "clearances/calculate.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

	end
end
