module Zoning
	module Zones

		def self.find(subdomain, locale, id)
			connection = Zoning::Connection.connect(subdomain, locale, "zones/#{id}.json")
			response = connection.get
			key = 'zone'
			Zoning::Connection.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = Zoning::Connection.connect(subdomain, locale, "zones.json")
			response = connection.get
			key = 'zones'
			Zoning::Connection.parse(response, key)
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
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "zones/search.json", query_string)
			response = connection.get
			key = 'zones'
			Zoning::Connection.parse(response, key)

		end
	end
end