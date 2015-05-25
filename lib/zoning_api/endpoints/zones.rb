module ZoningAPI
	module Zones

		def self.find(subdomain, locale, id, format=nil)
			key = 'zone'
			if format.present? && ['json', 'geojson'].include?(format)
				format
			else
				format = 'json'				
			end
			connection = ZoningAPI::Connection.connect(subdomain, locale, "zones/#{id}.#{format}").get
			ZoningAPI::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale, query={}, format=nil)
			key = 'zones'
			if format.present? && ['json', 'geojson'].include?(format)
				format
			else
				format = 'json'				
			end
			query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
			connection = ZoningAPI::Connection.connect(subdomain, locale, "zones.#{format}", query_string).get
			ZoningAPI::Connection.parse(connection, key)
		end

	end
end
