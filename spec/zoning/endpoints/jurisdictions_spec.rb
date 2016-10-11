require 'spec_helper'

module ZoningAPI
  RSpec.describe Jurisdiction do

    before(:each) do
      configure_zoning
    end

    describe "#find" do
      it "returns nil if jurisdiction cannot be found by ID" do
        expect{Jurisdiction.find(-1)}.to raise_error(JsonApiClient::Errors::NotFound)
      end

      it "returns nil if jurisdiction cannot be found by slug" do
        expect{Jurisdiction.find('notfound')}.to raise_error(JsonApiClient::Errors::NotFound)
      end

      it "returns jurisdiction by slug" do
        jurisdiction = Jurisdiction.find("orlando").first.to_h
        expect(jurisdiction["name"]).to eq("Orlando")
        expect(jurisdiction).to include("full_name")
        expect(jurisdiction).to include("bounds")
        expect(jurisdiction).to include("state")
        expect(jurisdiction).to include("zone_shapes")
        expect(jurisdiction).to include("boundary")
        expect(jurisdiction).to include("center")
      end

      it "returns jurisdiction by id" do
        jurisdiction = Jurisdiction.find(1).first.to_h
        expect(jurisdiction["name"]).to eq("San Francisco")
      end
    end
  end
end
