require "spec_helper"

RSpec.describe Cassieq::Client::Queues do
  let(:client) { Cassieq::Client.new(host: "192.168.99.100", account: "test", key: "xfXq7tTmZoz2phCicnhFCj4tPExxxDUTIIzOLcGRlkKkFP56DxF68aiabpqae8Ff9_D0GZdF4QqCh4PdqahDOA" )}

  describe "#queues", vcr: { cassette_name: "queues/queues" } do
    it "returns information about all queues" do
      response = client.queues
      expect(response.body).to include({
        "accountName"=>"test",
        "queueName"=>"what",
        "bucketSize"=>20,
        "maxDeliveryCount"=>5,
        "status"=>"Active",
        "version"=>0,
        "repairWorkerPollFrequencySeconds"=>5,
        "repairWorkerTombstonedBucketTimeoutSeconds"=>15,
        "deleteBucketsAfterFinalization"=>true,
        "queueStatsId"=>"b5df2e33-7419-403d-a0ec-f6b7e942f81c_test:what_v0",
        "dlqName"=>nil,
        "id"=>"test:what_v0"
      })
    end
  end

  describe "#create_queue", vcr: { cassette_name: "queues/create_queue" } do
    it "returns success" do
      response = client.create_queue(queueName: "what")
      expect(response.status).to eq(200)
    end
  end

  describe "#queue", vcr: { cassette_name: "queues/queue" } do
    it "returns information about the queue" do
      response = client.queue("what")
      expect(response.body).to eq({
        "accountName"=>"test",
        "queueName"=>"what",
        "bucketSize"=>20,
        "maxDeliveryCount"=>5,
        "status"=>"Active",
        "version"=>0,
        "repairWorkerPollFrequencySeconds"=>5,
        "repairWorkerTombstonedBucketTimeoutSeconds"=>15,
        "deleteBucketsAfterFinalization"=>true,
        "queueStatsId"=>"b5df2e33-7419-403d-a0ec-f6b7e942f81c_test:what_v0",
        "dlqName"=>nil,
        "id"=>"test:what_v0"
      })
    end 
  end

  describe "#delete_queue", vcr: { cassette_name: "queues/delete_queue" } do
    it "returns success" do
      response = client.delete_queue("what") do
        expect(response.status).to eq(200)
      end
    end
  end
end
