module Zoning
	module Tenants

		def self.find(subdomain, locale, id)
			connection = Zoning::Connection.connect(subdomain, locale, "tenants/#{id}.json")
			response = connection.get
			key = 'tenant'
			Zoning::Connection.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = Zoning::Connection.connect(subdomain, locale, "tenants.json")
			response = connection.get
			key = 'tenants'
			Zoning::Connection.parse(response, key)
		end

		# Tenants.search method takes the following, optional params:
		# :id, Integer
		# :name, String
		# :subdomain, String
		# :keywords, String

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "tenants/search.json", query_string)
			response = connection.get
			key = 'tenants'
			Zoning::Connection.parse(response, key)
		end

		def self.geojson(subdomain, locale)
			base_url = "http://d3twrm58ezzfsc.cloudfront.net/tenants/"
			connection = Faraday.new(:url => "#{base_url}#{subdomain}.geojson")
			response = connection.get
			if response.try(:body).present?
				begin
					Oj.load(response.body, bigdecimal_load: :float).to_json
				rescue
					"Invalid json response"
				end
			else
				"No response body"
			end
		end

	end
end