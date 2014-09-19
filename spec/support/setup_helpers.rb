module SetupHelpers
  def configure_zoning
    Zoning.configure do |c|
      c.protocol = 'http://'
    end
  end
end
