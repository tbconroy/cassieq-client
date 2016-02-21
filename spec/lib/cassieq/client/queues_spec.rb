require "spec_helper"

RSpec.describe Cassieq::Client::Queues do
  let(:client) { Cassieq::Client.new(host: "192.168.99.100", account: "test", key: "xfXq7tTmZoz2phCicnhFCj4tPExxxDUTIIzOLcGRlkKkFP56DxF68aiabpqae8Ff9_D0GZdF4QqCh4PdqahDOA" )}

  describe "#queues", vcr: { cassette_name: "queues/queues" } do
    it "returns information about all queues" do
      response = client.queues
      expect(response).to include({
        account_name: "test",
        queue_name: "what",
        bucket_size: 20,
        max_delivery_count: 5,
        status: "Active",
        version: 0,
        repair_worker_poll_frequency_seconds: 5,
        repair_worker_tombstoned_bucket_timeout_seconds: 15,
        delete_buckets_after_finalization: true,
        queue_stats_id: "b5df2e33-7419-403d-a0ec-f6b7e942f81c_test:what_v0",
        dlq_name: nil,
        id: "test:what_v0"
      })
    end
  end

  describe "#create_queue", vcr: { cassette_name: "queues/create_queue" } do
    it "returns true" do
      response = client.create_queue(queueName: "what")
      expect(response).to eq(true)
    end
  end

  describe "#queue", vcr: { cassette_name: "queues/queue" } do
    it "returns information about the queue" do
      response = client.queue("what")
      expect(response).to eq(
        account_name: "test",
        queue_name: "what",
        bucket_size: 20,
        max_delivery_count: 5,
        status: "Active",
        version: 0,
        repair_worker_poll_frequency_seconds: 5,
        repair_worker_tombstoned_bucket_timeout_seconds: 15,
        delete_buckets_after_finalization: true,
        queue_stats_id: "b5df2e33-7419-403d-a0ec-f6b7e942f81c_test:what_v0",
        dlq_name: nil,
        id: "test:what_v0"
      )
    end 
  end

  describe "#delete_queue", vcr: { cassette_name: "queues/delete_queue" } do
    it "returns true" do
      response = client.delete_queue("what")
      expect(response).to eq(true)
    end
  end
end
