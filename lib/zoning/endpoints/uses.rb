module Zoning
	module Uses

		def self.find(subdomain, locale, id)
			key = 'use'
			connection = Zoning::Connection.connect(subdomain, locale, "uses/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale)
			key = 'uses'
			connection = Zoning::Connection.connect(subdomain, locale, "uses.json").get
			Zoning::Connection.parse(connection, key)
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
			key = 'uses'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "uses/search.json", query_string).get
			Zoning::Connection.parse(connection, key)			
		end
	
	end

end