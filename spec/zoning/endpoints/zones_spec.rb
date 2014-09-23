require 'spec_helper'

module Zoning
  describe Zones do
    let(:locale) { :en }
    let(:subdomain) { :tenant }

    before(:each) do
      configure_zoning
      stub_token_fetch_success
    end

    describe "#search" do
      it "accepts valid search params" do
        stub_request(:get, /zones\/search\.json/)
        query = {
          id: 0,
          overlay: true,
          category_id: 0,
          name: '',
          code: '',
          description: '',
          latitude: 0.0,
          longitude: 0.0,
          radius: 0.0,
          keywords: ''
        }
        expect { Zones.search(subdomain, locale, query) }.to_not raise_error
        query.delete(:radius)
        expect { Zones.search(subdomain, locale, query) }.to_not raise_error
      end

      it "raises an error in presence of an undefined param" do
        stub_request(:get, /zones\/search\.json/)
        query = { name: 'valid', notaparam: 'invalid' }
        expect { Zones.search(subdomain, locale, query) }.
          to raise_error(InvalidParameterError, /notaparam/)
      end
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
