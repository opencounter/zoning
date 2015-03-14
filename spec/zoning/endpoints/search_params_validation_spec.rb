# require 'spec_helper'
#
# module Zoning
#   describe "Search parameter validation on #list" do
#       let(:locale) { :en }
#       let(:subdomain) { :jurisdiction }
#
#       before(:each) do
#         configure_zoning
#         stub_token_fetch_success
#       end
#
#
#       ##### ATTRIBUTES #####
#
#       describe "land_use_conditions" do
#         before(:each) do
#           stub_request(:get, /land_use_conditions\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             use: { slug: 'slug' }
#           }
#           expect { LandUseConditions.list(subdomain, locale, query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { slug: 'valid', notaparam: 'invalid' }
#           expect { LandUseConditions.list(subdomain, locale, query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#       end
#
#
#       ##### USES #####
#
#       describe "land_uses" do
#         before(:each) do
#           stub_request(:get, /land_uses\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             id: 0,
#             name: '',
#             full_name: '',
#             description: ''
#           }
#           expect { LandUses.list(subdomain, locale, query) }.to_not raise_error
#           query.delete(:name)
#           expect { LandUses.list(subdomain, locale, query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { name: 'valid', notaparam: 'invalid' }
#           expect { LandUses.list(subdomain, locale, query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#       end
#
#
#       ##### CLEARANCES #####
#
#       describe "clearances" do
#         before(:each) do
#           stub_request(:get, /clearances\/find\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             id: 0,
#             zone: '',
#             use: '',
#             permission: '',
#             parameters: ''
#           }
#           expect { Clearances.find(subdomain, locale, query) }.to_not raise_error
#           query.delete(:zone)
#           expect { Clearances.find(subdomain, locale, query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { name: 'valid', notaparam: 'invalid' }
#           expect { Clearances.find(subdomain, locale, query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#
#         before(:each) do
#           stub_request(:get, /clearances\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             use: { slug: 'test' },
#             parameters: [:attr1, :attr2]
#           }
#           expect { Clearances.list(subdomain, locale, query) }.to_not raise_error
#           query.delete(:use)
#           expect { Clearances.list(subdomain, locale, query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { use: 'valid', notaparam: 'invalid' }
#           expect { Clearances.list(subdomain, locale, query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#       end
#
#
#       ##### JURISDICTIONS #####
#
#       describe "jurisdictions" do
#         before(:each) do
#           stub_request(:get, /jurisdictions\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             id: 0,
#             name: '',
#             subdomain: ''
#           }
#           expect { Jurisdictions.list(query) }.to_not raise_error
#           query.delete(:subdomain)
#           expect { Jurisdictions.list(query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { name: 'valid', notaparam: 'invalid' }
#           expect { Jurisdictions.list(query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#       end
#
#
#       ##### PERMISSION TYPES #####
#
#       describe "permissions" do
#         before(:each) do
#           stub_request(:get, /permission_types\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             id: 0,
#             code: '',
#             name: '',
#             description: '',
#             type: ''
#           }
#           expect { PermissionTypes.list(subdomain, locale, query) }.to_not raise_error
#           query.delete(:type)
#           expect { PermissionTypes.list(subdomain, locale, query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { name: 'valid', notaparam: 'invalid' }
#           expect { Permissions.list(subdomain, locale, query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#       end
#
#
#       ##### ZONES #####
#
#       describe "zones" do
#         before(:each) do
#           stub_request(:get, /zones\.json/)
#         end
#
#         it "accepts valid search params" do
#           query = {
#             id: 0,
#             overlay: true,
#             name: '',
#             code: '',
#             description: '',
#             latitude: 0.0,
#             longitude: 0.0
#           }
#           expect { Zones.list(subdomain, locale, query) }.to_not raise_error
#           query.delete(:radius)
#           expect { Zones.list(subdomain, locale, query) }.to_not raise_error
#         end
#
#         it "raises an error in presence of an undefined param" do
#           query = { name: 'valid', notaparam: 'invalid' }
#           expect { Zones.list(subdomain, locale, query) }.
#             to raise_error(InvalidParameterError, /notaparam/)
#         end
#       end
#   end
# end
