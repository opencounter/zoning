require 'spec_helper'

module Zoning
  describe "Search parameter validation on #where" do
      let(:locale) { :en }
      let(:subdomain) { :tenant }

      before(:each) do
        configure_zoning
        stub_token_fetch_success
      end

      describe "zones" do
        before(:each) do
          stub_request(:get, /zones\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            overlay: true,
            name: '',
            code: '',
            description: '',
            latitude: 0.0,
            longitude: 0.0
          }
          expect { Zones.where(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "zone_clearances" do
        before(:each) do
          stub_request(:get, /zone_clearances\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'test' },
            parameters: [:attr1, :attr2]
          }
          expect { ZoneClearances.where(subdomain, locale, query) }.to_not raise_error
          query.delete(:use)
          expect { ZoneClearances.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { use: 'valid', notaparam: 'invalid' }
          expect { ZoneClearances.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "uses" do
        before(:each) do
          stub_request(:get, /uses\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            full_name: '',
            description: ''
          }
          expect { Uses.where(subdomain, locale, query) }.to_not raise_error
          query.delete(:name)
          expect { Uses.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Uses.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "attributes" do
        before(:each) do
          stub_request(:get, /attributes\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'slug' }
          }
          expect { Attributes.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { slug: 'valid', notaparam: 'invalid' }
          expect { Attributes.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "tenants" do
        before(:each) do
          stub_request(:get, /tenants\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            subdomain: ''
          }
          expect { Tenants.where(query) }.to_not raise_error
          query.delete(:subdomain)
          expect { Tenants.where(query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Tenants.where(query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "permissions" do
        before(:each) do
          stub_request(:get, /permissions\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            code: '',
            name: '',
            description: '',
            type: ''
          }
          expect { Permissions.where(subdomain, locale, query) }.to_not raise_error
          query.delete(:type)
          expect { Permissions.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Permissions.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "clearance" do
        before(:each) do
          stub_request(:get, /clearance\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            zone: '',
            use: '',
            permission: '',
            parameters: ''
          }
          expect { Clearance.where(subdomain, locale, query) }.to_not raise_error
          query.delete(:zone)
          expect { Clearance.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Clearance.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "zones#where" do
        before(:each) do
          stub_request(:get, /zones\/where\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            overlay: true,
            name: '',
            code: '',
            description: '',
            latitude: 0.0,
            longitude: 0.0
          }
          expect { Zones.where(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.where(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.where(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end
  end
end
