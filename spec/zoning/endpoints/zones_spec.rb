require 'spec_helper'

module Zoning
  describe Zones do
    let(:locale) { :en }
    let(:subdomain) { :tenant }

    before(:each) do
      configure_zoning
      stub_token_fetch_success
    end

    describe "#list" do
      it "invalid response gives \"Invalid json response\"" do
        stub_request(:get, /zones\.json/).
          to_return(status: 200, headers: {'Content-Type' => 'application/json'},
                    body: { 'zines' => [] }.to_json)
        zones = Zones.list(subdomain, locale)
        expect(zones).to eq("Invalid json response")
      end

      it "parses the response body as a list of zones" do
        stub_request(:get, /zones\.json/).
          to_return(status: 200, headers: {'Content-Type' => 'application/json'},
                    body: { 'zones' => 'anything' }.to_json)
        zones = Zones.list(subdomain, locale)
        expect(zones).to eq('anything')
      end

      context "no subdomain" do
        let(:subdomain) { nil }

        it "valid response is empty" do
          stub_request(:get, /zones\.json/).
            to_return(status: 200, headers: {'Content-Type' => 'application/json'},
                      body: { 'zones' => [] }.to_json)

          zones = Zones.list(subdomain, locale)
          expect(zones).to eq([])
        end
      end
    end
  end
end
