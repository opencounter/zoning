require 'spec_helper'

module Zoning
  describe "Search parameter validation on #search" do
      let(:locale) { :en }
      let(:subdomain) { :tenant }

      before(:each) do
        configure_zoning
        stub_token_fetch_success
      end

      describe "zones" do
        before(:each) do
          stub_request(:get, /zones\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            overlay: true,
            name: '',
            code: '',
            description: '',
            latitude: 0.0,
            longitude: 0.0,
            keywords: ''
          }
          expect { Zones.search(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.search(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "zone_clearances" do
        before(:each) do
          stub_request(:get, /zone_clearances\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'test' },
            parameters: [:attr1, :attr2]
          }
          expect { ZoneClearances.search(subdomain, locale, query) }.to_not raise_error
          query.delete(:use)
          expect { ZoneClearances.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { use: 'valid', notaparam: 'invalid' }
          expect { ZoneClearances.search(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "uses" do
        before(:each) do
          stub_request(:get, /uses\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            full_name: '',
            description: '',
            keywords: ''
          }
          expect { Uses.search(subdomain, locale, query) }.to_not raise_error
          query.delete(:name)
          expect { Uses.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Uses.search(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "attributes" do
        before(:each) do
          stub_request(:get, /attributes\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'slug' }
          }
          expect { Attributes.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { slug: 'valid', notaparam: 'invalid' }
          expect { Attributes.search(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "tenants" do
        before(:each) do
          stub_request(:get, /tenants\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            subdomain: '',
            keywords: ''
          }
          expect { Tenants.search(query) }.to_not raise_error
          query.delete(:keywords)
          expect { Tenants.search(query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Tenants.search(query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "permissions" do
        before(:each) do
          stub_request(:get, /permissions\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            code: '',
            name: '',
            description: '',
            keywords: '',
            type: ''
          }
          expect { Permissions.search(subdomain, locale, query) }.to_not raise_error
          query.delete(:type)
          expect { Permissions.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Permissions.search(subdomain, locale, query) }.
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
          expect { Clearance.search(subdomain, locale, query) }.to_not raise_error
          query.delete(:zone)
          expect { Clearance.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Clearance.search(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end

      describe "zones#search" do
        before(:each) do
          stub_request(:get, /zones\/search\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            overlay: true,
            name: '',
            code: '',
            description: '',
            latitude: 0.0,
            longitude: 0.0,
            keywords: ''
          }
          expect { Zones.search(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.search(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.search(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end
  end
end
