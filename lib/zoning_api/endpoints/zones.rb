module ZoningAPI
	module Zones

		def self.find(subdomain, locale, id, options={})
			key = 'zone'
			if options[:format].present? && ['json', 'geojson'].include?(options[:format])
				format = options[:format]
			else
				format = 'json'				
			end
			connection = ZoningAPI::Connection.connect(subdomain, locale, "zones/#{id}.#{format}").get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={})
			key = 'zones'
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "zones.json", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

	end
end
