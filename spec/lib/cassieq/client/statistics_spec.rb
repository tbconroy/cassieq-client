require "spec_helper"

RSpec.describe Cassieq::Client::Queues do
  let(:client) { Cassieq::Client.new(host: CONFIG["host"], account: "test", key: CONFIG["key"] )}
  let(:create_queue) { client.create_queue(queueName: "test_queue") }
  let(:create_message) { client.create_message("test_queue", "Here is message") }
  let(:delete_queue) { client.delete_queue("test_queue") }

  describe "#statistics", vcr: { cassette_name: "statistics/statistics" } do
    let(:statistics) { client.statistics("test_queue") }

    it "returns statistical information" do
      create_queue
      create_message
      expect(statistics).to eq(size: 1)
      delete_queue
    end
  end
end
