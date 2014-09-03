module Zoning
	module Tenants

		def self.find(subdomain, locale, id)
			key = 'tenant'
			connection = Zoning::Connection.connect(subdomain, locale, "tenants/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list(subdomain, locale)
			key = 'tenants'
			connection = Zoning::Connection.connect(subdomain, locale, "tenants.json").get
			Zoning::Connection.parse(connection, key)
		end

		# Tenants.search method takes the following, optional params:
		# :id, Integer
		# :name, String
		# :subdomain, String
		# :keywords, String

		def self.search(subdomain, locale, query={})
			key = 'tenants'
			query_string = {q: query}.to_query
			connection = Zoning::Connection.connect(subdomain, locale, "tenants/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.geojson(subdomain, locale)
			base_url = "http://d3twrm58ezzfsc.cloudfront.net/tenants/"
			connection = Faraday.new(:url => "#{base_url}#{subdomain}.geojson").get
			if connection.try(:body).present?
				begin
					Oj.load(connection.body, bigdecimal_load: :float).to_json
				rescue
					"Invalid json response"
				end
			else
				"No response body"
			end
		end

	end
end