require "zoning/configuration"
require "zoning/connection"
require "zoning/version"
require "zoning/connection_failed_error"
require "zoning/invalid_parameter_error"
require "zoning/configuration_error"
require "zoning/search_params_validator"

require "zoning/endpoints/attributes"
require "zoning/endpoints/clearances"
require "zoning/endpoints/geo"
require "zoning/endpoints/jurisdictions"
require "zoning/endpoints/land_uses"
require "zoning/endpoints/permission_types"
require "zoning/endpoints/zones"

require 'oj'
require 'faraday'
require 'faraday_middleware'

module Zoning
  class << self
    attr_accessor :configuration
    attr_accessor :connection
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
