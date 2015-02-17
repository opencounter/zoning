class ZoningAPI::ConnectionFailedError < StandardError
  attr_reader :code, :response

  def initialize(code: nil, response: nil)
    super("#{code}: #{response}")
  end
end
