module Zoning
	module Zones

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

		# Zones.search takes the following, optional params:
		# :id, Integer
		# :overlay, Boolean
		# :category_id, Integer
		# :name, String
		# :code, String
		# :description, String
		# :latitude, Float
		# :longitude, Float
		# :radius, Integer
		# :keywords, String

		def self.search(subdomain, locale, query={})
			key = 'zones'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zones/search.json", query_string).get
			Zoning::Connection.parse(connection, key)

		end
	end
end