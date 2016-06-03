module SetupHelpers
  def configure_zoning
    ZoningAPI::Base.configure("http://zoning-api-next.com/en/api/1.0/")
  end
end
