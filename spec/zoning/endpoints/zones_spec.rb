require 'spec_helper'

module ZoningAPI
  describe Zone do
    let(:locale) { :en }
    let(:tenant) { :orlando }
    let(:code) { "AC-1" }

    before do
      configure_zoning
    end

    describe "#find" do
      it "find by id in correct format" do
        zones = Zone.list(tenant)
        zone = Zone.lookup(tenant, zones.first["id"])

        expect(zones.first["id"]).to eq(zone["id"])
        expect(zone).to include("code")
        expect(zone).to include("description")
        expect(zone).to include("overlay")
      end
    end

    describe "#list" do
      it "returns [] if cannot parse response" do
        stub_request(:get, /zones/).
          to_return(status: 200, headers: {'Content-Type' => 'application/json'},
                    body: { 'zzoonneess' => [] }.to_json)
        zones = Zone.list(tenant)
        expect(zones).to eq([])
      end

      it "resultless without subdomain" do
        zones = Zone.list(nil)
        expect(zones).to be_empty()
      end

      it "resultless without subdomain" do
        zones = Zone.list(nil)
        expect(zones).to be_empty()
      end

      it "returns data that looks like a zone" do
        zones = Zone.list(tenant)
        zone = zones.first

        expect(zone).to include("code")
        expect(zone).to include("description")
        expect(zone).to include("overlay")
        expect(zone).to include("geom")
      end

      it "returns zone matching code" do
        zones = Zone.list(tenant, filters: { code: code })
        expect(zones.first["code"]).to eq(code)
      end
    end
  end
end
