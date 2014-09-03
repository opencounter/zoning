module Zoning
	module Uses

		def self.find(subdomain, locale, id)
			connection = Zoning::Connection.connect(subdomain, locale, "uses/#{id}.json")
			response = connection.get
			key = 'use'
			Zoning::Connection.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = Zoning::Connection.connect(subdomain, locale, "uses.json")
			response = connection.get
			key = 'uses'
			Zoning::Connection.parse(response, key)
		end

		# Uses.search takes the following, optional params:
		# :id, Integer
		# :category_id, Integer
		# :name, String
		# :full_name, String
		# :code, String
		# :description, String
		# :keywords, String

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "uses/search.json", query_string)
			response = connection.get
			key = 'uses'
			Zoning::Connection.parse(response, key)			
		end
	
	end

end