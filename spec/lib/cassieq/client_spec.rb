require "spec_helper"

RSpec.describe Cassieq::Client do
  let(:base_params) { { host: CONFIG["host"], account: CONFIG["account"] } }
  let(:client) { Cassieq::Client.new(params) }

  context "with key based authorization", vcr: { cassette_name: "client/key_auth" } do
    let(:key_auth) { { key: CONFIG["key"] } }
    let(:params) { base_params.merge(key_auth) }

    it "suceeds" do
      response = client.queues
      expect(response).to eq(true)
    end
  end

  context "with query param based authorization", vcr: { cassette_name: "client/query_param_auth" } do
    let(:query_param_auth) { { auth: "g", sig: CONFIG["sig"] } }
    let(:params) { base_params.merge(query_param_auth) }

    it "succeeds" do
      response = client.queues
      expect(response).to eq(true)
    end
  end
  
  context "with no authorization", vcr: { cassette_name: "client/no_auth" } do
    let(:params) { base_params }

    it "raises unauthorized error" do
      expect{ client.queues }.to raise_error(Cassieq::Unauthorized, "HTTP 401 Unauthorized")
    end
  end
end
