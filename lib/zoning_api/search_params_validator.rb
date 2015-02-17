module ZoningAPI
  module SearchParamsValidator
    module BaseValidator
      def query(arg1, arg2=nil, arg3=nil)
        if arg2 == nil && arg3 == nil
          subdomain = nil
          locale = nil
          query = arg1
        else
          subdomain = arg1
          locale = arg2
          query = arg3
        end

        extra_params = query.keys - self::ALLOWED_SEARCH_PARAMS
        if extra_params.empty?
          if subdomain && locale
            super(subdomain, locale, query)
          else
            super(query)
          end
        else
          raise ZoningAPI::InvalidParameterError.new(extra_params)
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
