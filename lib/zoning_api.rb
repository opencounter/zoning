require "faraday"
require 'json_api_client'

module ZoningAPI
  VERSION = "0.0.4"

  class Base < JsonApiClient::Resource
    def self.configure(site)
      # The connection seems to already get created which captures
      # site, so rebuild the connection post configuration
      self.site = site
      self.connection(true)
    end

    # Legacy shim
    def self.list(jurisdiction, locale: I18n.locale, filters: {}, includes: [])
      with_jurisdiction(jurisdiction, locale).includes(includes).where(filters).map(&:to_h)
    end

    def self.lookup(jurisdiction, id, locale: I18n.locale, includes: [])
      with_jurisdiction(jurisdiction, locale).includes(includes).find(id).first.to_h
    end

    def self.with_defaults(params)
      Thread.current[:default_zoning_params] = params
      # raise RuntimeError.new(Thread.current[:default_zoning_params])
      yield
    ensure
      Thread.current[:default_zoning_params] = nil
    end

    def self.with_jurisdiction(jurisdiction, locale=I18n.locale)
      with_params(jurisdiction: jurisdiction, locale: locale)
    end

    def to_h
      relationships.as_json.each_with_object(attributes) do |(name, attrs), h|
        next unless attrs.include?("data")

        # json-api responds to unincluded relations but raises if accessed
        begin
          val = public_send(name)
        rescue NoMethodError
          # expose ids even for unincluded relations
          val = attrs["data"]
        end

        h[name] = val.kind_of?(Array) ? val.map(&:to_h) : val.to_h
      end
    end

    def self._new_scope
      super.with_params(Thread.current[:default_zoning_params] || {})
    end
  end

  class Category < Base
  end

  class Clearance < Base
    has_one :zone
    has_one :permission
    has_one :use
  end

  class Jurisdiction < Base
  end

  class Rule < Base
  end

  class Use < Base
  end

  class Permission < Base
  end

  class Zone < Base
  end

end

ZoningAPI::Base.connection do |connection|
  # connection.use FaradayMiddleware::OAuth2, 'MYTOKEN'
  connection.use Faraday::Response::Logger
end

