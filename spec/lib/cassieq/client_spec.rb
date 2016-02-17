require "spec_helper"

RSpec.describe Cassieq::Client do

  describe "configuration" do
    it "sets the url prefix on the connection object" do
      client = Cassieq::Client.new({ host: "coolguys.org", account: "cool", key: "66666666" })
      expect(client.connection.url_prefix.to_s).to eq("http://coolguys.org:8080/api/v1/accounts/cool")
    end

    context "with key based authorization" do
      let!(:client) { Cassieq::Client.new({ host: "coolguys.org", key: "66666666" }) }

      it "adds authorization header to the connection object" do
        expect(client.connection.headers).to include("Authorization" => "Key 66666666")
      end
    end

    it "sets the account" do
      client = Cassieq::Client.new({ host: "coolguys.org", account: "rick_and_morty" })
      expect(client.account).to eq("rick_and_morty")
    end

    context "with query param based authorization" do
      let!(:client) { Cassieq::Client.new({ host: "coolguys.org", auth: "puag", sig: "NygRs9GBh9n" }) }

      it "adds auth params to the connection object" do
        expect(client.connection.params).to include("auth" => "puag", "sig" => "NygRs9GBh9n")
      end
    end
  end
end
