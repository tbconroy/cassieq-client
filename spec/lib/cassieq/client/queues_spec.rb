require "spec_helper"

RSpec.describe Cassieq::Client::Queues do
  let(:client) { Cassieq::Client.new(host: CONFIG["host"], account: CONFIG["account"], key: CONFIG["key"] )}
  let(:create_queue) { client.create_queue({ queue_name: "test_queue" }, true) }
  let(:delete_queue) { client.delete_queue("test_queue") }

  describe "#create_queue" do
    it "returns true" do
      expect(create_queue).to eq(true)
      delete_queue
    end
  end

  describe "#queues" do
    let(:queues) { client.queues }

    it "returns information about all queues" do
      create_queue
      expect(queues.size).to eq(1)
      expect(queues[0].size).to eq(13)
      expect(queues[0]).to include(account_name: CONFIG["account"], queue_name: "test_queue", id: "#{CONFIG["account"]}:test_queue_v0")
      delete_queue
    end
  end

  describe "#queue" do
    let(:queue) { client.queue("test_queue") }

    it "returns information about the queue" do
      create_queue
      expect(queue.size).to eq(13)
      expect(queue).to include(account_name: CONFIG["account"], queue_name: "test_queue", id: "#{CONFIG["account"]}:test_queue_v0")
      delete_queue
    end 
  end

  describe "#delete_queue" do
    it "returns true" do
      create_queue
      expect(delete_queue).to eq(true)
    end
  end
end
