require "spec_helper"

RSpec.describe Cassieq::Client::Messages do
  let(:client) { Cassieq::Client.new(host: "192.168.99.100", account: "test", key: "xfXq7tTmZoz2phCicnhFCj4tPExxxDUTIIzOLcGRlkKkFP56DxF68aiabpqae8Ff9_D0GZdF4QqCh4PdqahDOA" )}

  describe "#next_message", vcr: { cassette_name: "messages/next_message" } do
    it "returns message" do
      response = client.next_message("test_queue")
      expect(response.body).to eq({
        "popReceipt" => "NDoyOmJGZzlYZw",
        "message" => "Don't fake the funk on a nasty dunk",
        "deliveryCount" => 0,
        "messageTag" => "bFg9Xg"
      })
    end
  end

  describe "#create_message", vcr: { cassette_name: "messages/create_message" } do
    it "returns success" do
      response = client.create_message("test_queue", "Don't fake the funk on a nasty dunk")
      expect(response.status).to eq(201)
    end
  end

  describe "#edit_message", vcr: { cassette_name: "messages/edit_message" } do
    it "returns information about the queue" do
      pop_receipt = "NDoyOmJGZzlYZw"
      response = client.edit_message("test_queue", pop_receipt, message: "Tacos tonight!")
      expect(response.status).to eq(200)
      expect(response.body).to eq({
        "popReceipt" => "NDozOmJGZzlYZw",
        "messageTag" => "bFg9Xg"
      })
    end 
  end

  describe "#delete_message", vcr: { cassette_name: "messages/delete_message" } do
    it "returns success" do
      pop_receipt = "MDoyOm1qdWpvdw"
      response = client.delete_message("test_queue", pop_receipt) do
        expect(response.status).to eq(200)
      end
    end
  end
end
