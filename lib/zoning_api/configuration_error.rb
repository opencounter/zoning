class ZoningAPI::ConfigurationError < StandardError
  def initialize(type)
    case type
    when :client_id
      super("Missing configuration field: client_id")
    when :client_secret
      super("Missing configuration field: client_secret")
    end
  end
end
