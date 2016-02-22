require "spec_helper"

RSpec.describe Cassieq::Client::Queues do
  let(:client) { Cassieq::Client.new(host: CONFIG["host"], account: "test", key: CONFIG["key"] )}

  describe "#statistics", vcr: { cassette_name: "statistics/statistics" } do
    it "returns statistical information" do
      response = client.statistics("test_queue")
      expect(response).to eq(size: 2)
    end
  end
end
