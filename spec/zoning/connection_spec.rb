require 'spec_helper'

module Zoning
  describe Connection do
    before(:each) do
      configure_zoning
    end

    describe "configuration" do
      before(:each) do
        stub_token_fetch_success
      end

      it "#connect raises no exception when correctly configured" do
        expect { Connection.connect }.to_not raise_exception
      end

      it "#connect raises ConfigurationError when missing the client_id" do
        Zoning.configure do |c|
          c.client_secret = 'secret'
          c.client_id = nil
        end
        expect { Connection.connect }.to raise_exception(ConfigurationError, /client_id/)
      end

      it "#connect raises ConfigurationError when missing the client_secret" do
        Zoning.configure do |c|
          c.client_secret = nil
          c.client_id = 'id'
        end
        expect { Connection.connect }.to raise_exception(ConfigurationError, /client_secret/)
      end
    end

    describe "#connect" do
      context "happy path" do
        it "gives a Faraday object" do
          stub_token_fetch_success
          connection = Connection.connect(:subdomain, :en, '/')

          expect(connection.class).to eq(Faraday::Connection)
        end

        it "Faraday includes token in header" do
          flexmock(Connection).should_receive(:acc_token).and_return('valid').once
          connection = Connection.connect(:subdomain, :en, '/')

          expect(connection.builder.app.instance_variable_get(:@token).inspect).
            to eq("\"valid\"")
        end
      end

      context "sad path" do
        describe "fetching the access token takes longer than 3 seconds" do
          it "raises a connection failed timeout error" do
            flexmock(OAuth2::Client).should_receive(:new).and_raise(
              flexmock(StandardError.new, code: 408, response: 'Timeout')
            )

            expect { Connection.connect(:subdomain, :en, '/') }.to raise_error(
              ConnectionFailedError, /Timeout/
            )
          end
        end

        describe "access token is not returned because OAuth server 500 errors" do
          it "raises an connection failed internal error" do
            flexmock(OAuth2::Client).should_receive(:new).and_raise(
              flexmock(StandardError.new('message'))
            )

            expect { Connection.connect(:subdomain, :en, '/') }.to raise_error(
              ConnectionFailedError, /500/
            )
          end
        end
      end
    end
  end
end
