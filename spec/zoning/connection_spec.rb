require 'spec_helper'

describe Zoning::Connection do
  describe "configuration" do
    before(:each) do
      stub_token_fetch_success
    end

    context "correctly configured" do
      it "#connect raises no exception" do
        configure_zoning
        expect { Zoning::Connection.connect }.to_not raise_exception
      end
    end
  end

  describe "#connect" do
    before(:each) do
      configure_zoning
    end

    context "happy path" do
      it "gives a Faraday object" do
        configure_zoning
        flexmock(Zoning::Connection).should_receive(:acc_token).and_return('valid').once
        connection = Zoning::Connection.connect(:subdomain, :en, '/')

        expect(connection.class).to eq(Faraday::Connection)
      end

      it "Faraday includes token in header" do
        configure_zoning
        flexmock(Zoning::Connection).should_receive(:acc_token).and_return('valid').once
        connection = Zoning::Connection.connect(:subdomain, :en, '/')

        expect(connection.builder.app.instance_variable_get(:@token).inspect).
          to eq("\"valid\"")
      end
    end

    context "sad path" do
      describe "fetching the access token takes longer than 3 seconds" do
        it "raises a connection failed timeout error" do
          configure_zoning
          flexmock(OAuth2::Client).should_receive(:new).and_raise(
            flexmock(StandardError.new, code: 408, response: 'Timeout')
          )

          expect { Zoning::Connection.connect(:subdomain, :en, '/') }.to raise_error(
            Zoning::ConnectionFailedError, /Timeout/
          )
        end
      end

      describe "access token is not returned because OAuth server 500 errors" do
        it "raises an connection failed internal error" do
          configure_zoning
          flexmock(OAuth2::Client).should_receive(:new).and_raise(
            flexmock(StandardError.new('message'))
          )

          expect { Zoning::Connection.connect(:subdomain, :en, '/') }.to raise_error(
            Zoning::ConnectionFailedError, /500/
          )
        end
      end
    end
  end
end
