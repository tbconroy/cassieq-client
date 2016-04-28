require "spec_helper"

RSpec.describe Cassieq::Client do
  let(:base_params) { { host: CONFIG["host"], account: CONFIG["account"] } }
  let(:client) { Cassieq::Client.new(params) }

  context "with key based authorization" do
    let(:key_auth) { { key: CONFIG["key"] } }
    let(:params) { base_params.merge(key_auth) }

    it "suceeds" do
      response = client.queues
      expect(response).to eq(true)
    end
  end

  context "with query param based authorization" do
    let(:signed_query_string_auth) { { provided_params: CONFIG["provided_params"] } }
    let(:params) { base_params.merge(signed_query_string_auth) }

    it "succeeds" do
      response = client.queues
      expect(response).to eq(true)
    end
  end
  
  context "with no authorization" do
    let(:params) { base_params }

    it "raises unauthorized error" do
      expect{ client.queues }.to raise_error(Cassieq::Unauthorized, "HTTP 401 Unauthorized")
    end
  end
end
