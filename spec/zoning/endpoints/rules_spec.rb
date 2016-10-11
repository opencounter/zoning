require 'spec_helper'

module ZoningAPI
  describe Rule do
    let(:tenant) { :orlando }

    before do
      configure_zoning
    end

    describe "#list" do
      it "returns data that looks like a rule" do
        id = Rule.with_jurisdiction(tenant).select("id").first.to_h["id"]
        rule = Rule.lookup(tenant, id, includes: [:zones, :uses])

        expect(rule).to include("name")
        expect(rule).to include("uses")
        expect(rule["uses"].first).to include("slug")
        expect(rule).to include("zones")
        expect(rule).to include("prompt")
        expect(rule).to include("rule_type")
      end
    end

    describe "#lookup" do
      it "returns rule" do
        rules = Rule.list(tenant)
        id = rules.first["id"]
        rule = Rule.lookup(tenant, id)

        expect(rule["id"]).to eq(id)
        expect(rule).to include("name")
        expect(rule).to include("prompt")
        expect(rule).to include("rule_type")
      end
    end
  end
end
