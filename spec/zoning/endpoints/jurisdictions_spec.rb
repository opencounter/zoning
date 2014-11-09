require 'spec_helper'

module Zoning
  RSpec.describe Jurisdictions do

    before(:each) do
      configure_zoning
      stub_token_fetch_success
    end

    describe "#find" do
      it "returns nil if jurisdiction cannot be found by ID" do
        stub_request(:get, /jurisdictions\/1\.json/).
          to_return(status: 404, headers: {'Content-Type' => 'application/json'})

        jurisdiction = Jurisdictions.find(1)
        expect(jurisdiction).to eq(nil)
      end

      it "returns nil if jurisdiction cannot be found by slug" do
        stub_request(:get, /jurisdictions\/unknown\.json/).
          to_return(status: 404, headers: {'Content-Type' => 'application/json'})

        jurisdiction = Jurisdictions.find('unknown')
        expect(jurisdiction).to eq(nil)
      end
    end
  end
end
