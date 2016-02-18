require "spec_helper"


RSpec.describe Cassieq::Client do
  let(:base_params) { { host: "192.168.99.100", account: "test" } }
  let(:client) { Cassieq::Client.new(params) }

  describe "key based authorization", vcr: { cassette_name: "client/key_auth" } do
    let(:key_auth) { { key: "xfXq7tTmZoz2phCicnhFCj4tPExxxDUTIIzOLcGRlkKkFP56DxF68aiabpqae8Ff9_D0GZdF4QqCh4PdqahDOA" } }
    let(:params) { base_params.merge(key_auth) }

    it "returns successful" do
      response = client.queues
      expect(response.status).to eq(200)
    end
  end

  describe "query param based authorization", vcr: { cassette_name: "client/query_param_auth" } do
    let(:query_param_auth) { { auth: "rpuagcd", sig: "W-F4sCCslK5GZueIDPRW-CfUBOPWO61e2dk-eYjWiE4" } }
    let(:params) { base_params.merge(query_param_auth) }

    it "returns successful" do
      response = client.queues
      expect(response.status).to eq(200)
    end
  end
end
