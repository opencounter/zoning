class ZoningAPI::InvalidParameterError < StandardError
  def initialize(params)
    super("Invalid search keys: #{params.join(", ").chomp(", ")}")
  end
end
