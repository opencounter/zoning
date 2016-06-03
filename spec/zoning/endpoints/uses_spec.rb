require 'spec_helper'

module ZoningAPI
  describe Use do
    let(:locale) { :en }
    let(:tenant) { :orlando }

    before do
      configure_zoning
    end

    describe "#list" do
      it "returns data that looks like a use" do
        use = Use.list(tenant).first.to_h

        expect(use).to include("name")
        expect(use).to include("category_ids")
        expect(use).to include("icon_label")
        expect(use).to include("icon_url")
        expect(use).to include("category_name")
      end
    end

    describe "#find" do
      it "returns use" do
        query = { jurisdiction: tenant, locale: locale }
        use_id = Use.with_params(query).select("id").first.id
        use = Use.with_params(query).find(use_id).first.to_h

        expect(use["id"]).to eq(use_id)
        expect(use).to include("name")
        expect(use).to include("category_ids")
        expect(use).to include("icon_label")
        expect(use).to include("icon_url")
        expect(use).to include("category_name")
      end
    end
  end
end
