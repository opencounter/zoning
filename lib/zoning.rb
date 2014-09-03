require "zoning/configuration"
require "zoning/connection"
require "zoning/version"

require 'oj'
require 'faraday'

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
