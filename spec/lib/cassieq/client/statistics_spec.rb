require "spec_helper"

RSpec.describe Cassieq::Client::Queues do
  let(:client) { Cassieq::Client.new(host: "192.168.99.100", account: "test", key: "xfXq7tTmZoz2phCicnhFCj4tPExxxDUTIIzOLcGRlkKkFP56DxF68aiabpqae8Ff9_D0GZdF4QqCh4PdqahDOA" )}

  describe "#statistics", vcr: { cassette_name: "statistics/statistics" } do
    it "returns statistical information" do
      response = client.statistics("test_queue")
      expect(response).to eq(size: 2)
    end
  end
end
