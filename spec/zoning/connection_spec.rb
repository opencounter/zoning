require 'spec_helper'

describe Zoning::Connection do
  describe "#connect" do
    context "happy path" do
      xit "gives a Faraday object" do
      end

      xit "requests made through Faraday include the access token" do
      end
    end

    context "sad path" do
      describe "fetching the access token takes longer than 3 seconds" do
        xit "raises a connection failed timeout error" do
        end
      end

      describe "access token is not returned because of invalid credentials" do
        xit "raises a connection failed access denied error" do
        end
      end

      describe "access token is not returned because OAuth server 500 errors" do
        xit "raises an connection failed internal error" do
        end
      end
    end
  end
end
