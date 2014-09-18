module Zoning
  class Configuration
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :username
    attr_accessor :password
    attr_accessor :token_path
    attr_accessor :site_url
    attr_accessor :protocol

    def initialize
      @token_path = "/admin/oauth/token"
      @default_locale = :en
    end
  end
end
