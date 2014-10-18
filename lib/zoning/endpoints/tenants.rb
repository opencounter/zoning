module Zoning
	module Tenants
    prepend SearchParamsValidator

		def self.find(id)
			key = 'tenant'
			connection = Zoning::Connection.connect(nil, :en, "tenants/#{id}.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.list
			key = 'tenants'
			connection = Zoning::Connection.connect(nil, :en, "tenants.json").get
			Zoning::Connection.parse(connection, key)
		end

		def self.search(keywords)
			key = 'tenant'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(nil, :en, "tenants/search.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

    ALLOWED_SEARCH_PARAMS = %i(id name slug subdomain featured)
    def self.where(query={})
			key = 'tenants'
			query_string = Faraday::Utils::ParamsHash.new.merge({q: query}).to_query
			connection = Zoning::Connection.connect(nil, :en, "tenants/where.json", query_string).get
			Zoning::Connection.parse(connection, key)
		end

		def self.geojson(subdomain)
			base_url = "http://d3twrm58ezzfsc.cloudfront.net/tenants/"
			connection = Faraday.new(:url => "#{base_url}#{subdomain}.geojson").get
			if connection.try(:body).present?
				begin
					Oj.load(connection.body, bigdecimal_load: :float).to_json
				rescue
					puts "Zoning API Error: invalid json response"
					return nil
				end
			else
				puts "Zoning API Error: no response body"
				return nil
			end
		end

	end
end
