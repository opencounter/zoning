module ZoningAPI
  module Categories
    def self.find(subdomain, locale, id)
      key = 'categories'
      connection = ZoningAPI::Connection.connect(subdomain, locale, "categories/#{id}.json").get
      ZoningAPI::Connection.parse(connection, key)
    end

    def self.list(subdomain, locale, query={})
      key = 'categories'
      query_string = Faraday::Utils::ParamsHash.new.merge(query).to_query
      connection = ZoningAPI::Connection.connect(subdomain, locale, "categories.json", query_string).get
      ZoningAPI::Connection.parse(connection, key)
    end

  end

end
