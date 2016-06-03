require 'spec_helper'

module ZoningAPI
  describe Permission do
    let(:locale) { :en }
    let(:tenant) { :orlando }

    before do
      configure_zoning
    end

    describe "#list" do
      it "returns data that looks like a permission" do
        permissions = Permission.list(tenant)
        permission = permissions.first.to_h

        expect(permission).to include("code")
        expect(permission).to include("display_name")
        expect(permission).to include("type")
      end
    end
  end
end
