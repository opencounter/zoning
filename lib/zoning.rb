require "zoning/configuration"
require "zoning/version"

require 'oj'
require 'faraday'


module ZoningAPI

	module Attributes
		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = ZoningAPI.connect(subdomain, locale, "attributes/search.json", query_string)
			response = connection.get
			ZoningAPI.parse(response)
		end
	end

	module Clearances
		def self.find(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = ZoningAPI.connect(subdomain, locale, "clearance.json", query_string)
			response = connection.get
			key = 'clearance'
			ZoningAPI.parse(response, key)
		end
	end

	module Geo

		# Geo.geocode takes the folling, required params:
		# :address, String

		def self.geocode(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = ZoningAPI.connect(subdomain, locale, "geocode.json", query_string)
			response = connection.get
			key = 'addresses'
			ZoningAPI.parse(response, key)
		end
	end

	module Permissions
		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = ZoningAPI.connect(subdomain, locale, "permissions/search.json", query_string)
			response = connection.get
			key = 'permissions'
			ZoningAPI.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = ZoningAPI.connect(subdomain, locale, "permissions.json")
			response = connection.get
			key = 'permissions'
			ZoningAPI.parse(response, key)
		end
	end

	module Tenants

		def self.find(subdomain, locale, id)
			connection = ZoningAPI.connect(subdomain, locale, "tenants/#{id}.json")
			response = connection.get
			key = 'tenant'
			ZoningAPI.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = ZoningAPI.connect(subdomain, locale, "tenants.json")
			response = connection.get
			key = 'tenants'
			ZoningAPI.parse(response, key)
		end

		# Tenants.search method takes the following, optional params:
		# :id, Integer
		# :name, String
		# :subdomain, String
		# :keywords, String

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = ZoningAPI.connect(subdomain, locale, "tenants/search.json", query_string)
			response = connection.get
			key = 'tenants'
			ZoningAPI.parse(response, key)
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

	module Uses

		def self.find(subdomain, locale, id)
			connection = ZoningAPI.connect(subdomain, locale, "uses/#{id}.json")
			response = connection.get
			key = 'use'
			ZoningAPI.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = ZoningAPI.connect(subdomain, locale, "uses.json")
			response = connection.get
			key = 'uses'
			ZoningAPI.parse(response, key)
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
			connection = ZoningAPI.connect(subdomain, locale, "uses/search.json", query_string)
			response = connection.get
			key = 'uses'
			ZoningAPI.parse(response, key)			
		end
	
	end

	module Zones

		def self.find(subdomain, locale, id)
			connection = ZoningAPI.connect(subdomain, locale, "zones/#{id}.json")
			response = connection.get
			key = 'zone'
			ZoningAPI.parse(response, key)
		end

		def self.list(subdomain, locale)
			connection = ZoningAPI.connect(subdomain, locale, "zones.json")
			response = connection.get
			key = 'zones'
			ZoningAPI.parse(response, key)
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
			connection = ZoningAPI.connect(subdomain, locale, "zones/search.json", query_string)
			response = connection.get
			key = 'zones'
			ZoningAPI.parse(response, key)

		end
	end

	module ZoneClearances

		def self.search(subdomain, locale, query={})
			query_string = {q: query}.to_query
			connection = ZoningAPI.connect(subdomain, locale, "zone_clearances/search.json", query_string)
			response = connection.get
			key = 'zone_clearances'
			ZoningAPI.parse(response, key)
		end
	
	end

	private

	def self.connect(subdomain, locale, path, query_string=nil)
		if locale.blank?
			locale = "en"
		else
			locale = locale.to_s
		end
		protocol = "https://"
		base_url = "zoning.io/#{locale}/api/1.0/"
		if query_string.present?
			conn = Faraday.new(:url => "#{protocol}#{subdomain}.#{base_url}#{path}?#{query_string}")
		else
			conn = Faraday.new(:url => "#{protocol}#{subdomain}.#{base_url}#{path}")
		end
		conn.token_auth(ENV['ZONING_API_TOKEN'])
		conn
	end

	def self.parse(response, key=nil)
		if response.try(:body).present?
			if response.body == "HTTP Token: Access denied.\n"
				"HTTP Token: Access denied."
			else
				begin
					parsed_response = Oj.load(response.body, bigdecimal_load: :float)
					if key.present?
						parsed_response[key]
					else
						parsed_response
					end
				rescue
					"Invalid json response"
				end
			end
		else
			"No response body"
		end
	end

end