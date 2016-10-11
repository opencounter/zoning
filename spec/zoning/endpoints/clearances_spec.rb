require 'spec_helper'

module ZoningAPI
  describe Clearance do
    let(:locale) { :en }
    let(:tenant) { :orlando }

    before do
      configure_zoning
    end

    describe "#list" do
      it "returns data that looks like a clearance" do
        clearance = Clearance.with_params(jurisdiction: tenant, locale: locale) .where(use: { slug: "restaurant" })
          .includes(:zone, :use, :rule, :permission)
          .page(1).per(1).first.to_h

        expect(clearance).to include("zone")
        expect(clearance).to include("use")
        expect(clearance["use"]).to include("slug")
        expect(clearance).to include("rule")
        expect(clearance).to include("priority")
        expect(clearance).to include("permission")
      end
    end

    describe "#find" do
      it "returns clearance" do
        id = Clearance.with_params(jurisdiction: tenant, locale: locale)
          .where(use: { slug: "restaurant" })
          .select("id")
          .last.to_h["id"]

        clearance = Clearance.lookup(tenant, id, includes: [:zone])

        expect(clearance["id"]).to eq(id)
        expect(clearance["zone"]).to include("description")
        expect(clearance["zone"]).to include("overlay")
      end
    end
  end
end
