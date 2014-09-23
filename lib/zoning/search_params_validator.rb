module Zoning
  module SearchParamsValidator
    module BaseValidator
      def search(subdomain, locale, query={})
        extra_params = query.keys - self::ALLOWED_SEARCH_PARAMS
        if extra_params.empty?
          super(subdomain, locale, query)
        else
          raise Zoning::InvalidParameterError.new(extra_params)
        end
      end
    end

    def self.prepended(base)
      class << base
        prepend BaseValidator
      end
    end
  end
end
