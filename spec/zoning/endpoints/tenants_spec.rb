require 'spec_helper'

module Zoning
  RSpec.describe Tenants do

    before(:each) do
      configure_zoning
      stub_token_fetch_success
    end

    describe "#find" do
      it "returns nil if tenant cannot be found by ID" do
        stub_request(:get, /tenants\/1\.json/).
          to_return(status: 404, headers: {'Content-Type' => 'application/json'})

        tenant = Tenants.find(1)
        expect(tenant).to eq(nil)
      end

      it "returns nil if tenant cannot be found by slug" do
        stub_request(:get, /tenants\/unknown\.json/).
          to_return(status: 404, headers: {'Content-Type' => 'application/json'})

        tenant = Tenants.find('unknown')
        expect(tenant).to eq(nil)
      end
    end
  end
end
