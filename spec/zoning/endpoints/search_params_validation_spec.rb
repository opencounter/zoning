require 'spec_helper'

module Zoning
  describe "Search parameter validation on #query" do
      let(:locale) { :en }
      let(:subdomain) { :tenant }

      before(:each) do
        configure_zoning
        stub_token_fetch_success
      end

      describe "zones" do
        before(:each) do
          stub_request(:get, /zones\/query\.json/)
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
          expect { Zones.query(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.query(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "zone_clearances" do
        before(:each) do
          stub_request(:get, /zone_clearances\/query\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'test' },
            parameters: [:attr1, :attr2]
          }
          expect { ZoneClearances.query(subdomain, locale, query) }.to_not raise_error
          query.delete(:use)
          expect { ZoneClearances.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { use: 'valid', notaparam: 'invalid' }
          expect { ZoneClearances.query(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "uses" do
        before(:each) do
          stub_request(:get, /uses\/query\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            full_name: '',
            description: ''
          }
          expect { Uses.query(subdomain, locale, query) }.to_not raise_error
          query.delete(:name)
          expect { Uses.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Uses.query(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "attributes" do
        before(:each) do
          stub_request(:get, /attributes\/query\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'slug' }
          }
          expect { Attributes.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { slug: 'valid', notaparam: 'invalid' }
          expect { Attributes.query(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "tenants" do
        before(:each) do
          stub_request(:get, /tenants\/query\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            subdomain: ''
          }
          expect { Tenants.query(query) }.to_not raise_error
          query.delete(:subdomain)
          expect { Tenants.query(query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Tenants.query(query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "permissions" do
        before(:each) do
          stub_request(:get, /permissions\/query\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            code: '',
            name: '',
            description: '',
            type: ''
          }
          expect { Permissions.query(subdomain, locale, query) }.to_not raise_error
          query.delete(:type)
          expect { Permissions.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Permissions.query(subdomain, locale, query) }.
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
          expect { Clearance.query(subdomain, locale, query) }.to_not raise_error
          query.delete(:zone)
          expect { Clearance.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Clearance.query(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "zones#query" do
        before(:each) do
          stub_request(:get, /zones\/query\.json/)
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
          expect { Zones.query(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.query(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.query(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end
  end
end
