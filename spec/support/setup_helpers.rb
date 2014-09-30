module SetupHelpers
  def configure_zoning
    Zoning.configure do |c|
      c.client_id = 'client_id'
      c.client_secret = 'client_secret'
    end
  end

  def self.unconfigure_zoning
    Zoning.configuration = Zoning::Configuration.new
  end

  def stub_token_fetch_success
    stub_request(:post, /\/admin\/oauth\/token/).
      with(:body => {"grant_type"=>"client_credentials"}).
      to_return(status:  200,
                headers: {"Content-Type" => "application/json"},
                body:    {"access_token" => "token"})
  end
end
