require "zoning_api/configuration"
require "zoning_api/connection"
require "zoning_api/version"
require "zoning_api/connection_failed_error"
require "zoning_api/invalid_parameter_error"
require "zoning_api/configuration_error"
require "zoning_api/search_params_validator"

require "zoning_api/endpoints/categories"
require "zoning_api/endpoints/clearances"
require "zoning_api/endpoints/geo"
require "zoning_api/endpoints/jurisdictions"
require "zoning_api/endpoints/land_uses"
require "zoning_api/endpoints/land_use_conditions"
require "zoning_api/endpoints/permission_types"
require "zoning_api/endpoints/zones"

require 'oj'
require 'faraday'
require 'faraday_middleware'

module ZoningAPI
  class << self
    attr_accessor :configuration
    attr_accessor :connection
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
