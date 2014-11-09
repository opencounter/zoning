require 'spec_helper'

module Zoning
  describe "Search parameter validation on #list" do
      let(:locale) { :en }
      let(:subdomain) { :tenant }

      before(:each) do
        configure_zoning
        stub_token_fetch_success
      end


      ##### ATTRIBUTES #####

      describe "attributes" do
        before(:each) do
          stub_request(:get, /attributes\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'slug' }
          }
          expect { Attributes.list(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { slug: 'valid', notaparam: 'invalid' }
          expect { Attributes.list(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end


      ##### USES #####

      describe "land_uses" do
        before(:each) do
          stub_request(:get, /land_uses\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            full_name: '',
            description: ''
          }
          expect { LandUses.list(subdomain, locale, query) }.to_not raise_error
          query.delete(:name)
          expect { LandUses.list(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { LandUses.list(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end


      ##### CLEARANCES #####

      describe "clearances" do
        before(:each) do
          stub_request(:get, /clearances\/calculate\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            zone: '',
            use: '',
            permission: '',
            parameters: ''
          }
          expect { Clearances.calculate(subdomain, locale, query) }.to_not raise_error
          query.delete(:zone)
          expect { Clearances.calculate(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Clearances.calculate(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end

        before(:each) do
          stub_request(:get, /clearances\.json/)
        end

        it "accepts valid search params" do
          query = {
            use: { slug: 'test' },
            parameters: [:attr1, :attr2]
          }
          expect { Clearances.list(subdomain, locale, query) }.to_not raise_error
          query.delete(:use)
          expect { Clearances.list(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { use: 'valid', notaparam: 'invalid' }
          expect { Clearances.list(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end


      ##### PERMISSION #####

      describe "permissions" do
        before(:each) do
          stub_request(:get, /permissions\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            code: '',
            name: '',
            description: '',
            type: ''
          }
          expect { Permissions.list(subdomain, locale, query) }.to_not raise_error
          query.delete(:type)
          expect { Permissions.list(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Permissions.list(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end


      ##### TENANTS #####

      describe "tenants" do
        before(:each) do
          stub_request(:get, /tenants\.json/)
        end

        it "accepts valid search params" do
          query = {
            id: 0,
            name: '',
            subdomain: ''
          }
          expect { Tenants.list(query) }.to_not raise_error
          query.delete(:subdomain)
          expect { Tenants.list(query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Tenants.list(query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end


      ##### ZONES #####

      describe "zones" do
        before(:each) do
          stub_request(:get, /zones\.json/)
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
          expect { Zones.list(subdomain, locale, query) }.to_not raise_error
          query.delete(:radius)
          expect { Zones.list(subdomain, locale, query) }.to_not raise_error
        end

        it "raises an error in presence of an undefined param" do
          query = { name: 'valid', notaparam: 'invalid' }
          expect { Zones.list(subdomain, locale, query) }.
            to raise_error(InvalidParameterError, /notaparam/)
        end
      end
  end
end
