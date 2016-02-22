require "spec_helper"

RSpec.describe Cassieq::Client::Messages do
  let(:client) { Cassieq::Client.new(host: CONFIG["host"], account: "test", key: CONFIG["key"] )}

  describe "#next_message", vcr: { cassette_name: "messages/next_message" } do
    it "returns message" do
      response = client.next_message("test_queue")
      expect(response).to eq(pop_receipt: "NDoyOmJGZzlYZw", message: "Don't fake the funk on a nasty dunk", delivery_count: 0, message_tag: "bFg9Xg")
    end
  end

  describe "#create_message", vcr: { cassette_name: "messages/create_message" } do
    it "returns true" do
      response = client.create_message("test_queue", "Don't fake the funk on a nasty dunk")
      expect(response).to eq(true)
    end
  end

  describe "#edit_message", vcr: { cassette_name: "messages/edit_message" } do
    it "returns information about the message" do
      pop_receipt = "NDoyOmJGZzlYZw"
      response = client.edit_message("test_queue", pop_receipt, message: "Tacos tonight!")
      expect(response).to eq(pop_receipt: "NDozOmJGZzlYZw", message_tag: "bFg9Xg")
    end 
  end

  describe "#delete_message", vcr: { cassette_name: "messages/delete_message" } do
    it "returns true" do
      pop_receipt = "NDo0OmJGZzlYZw"
      response = client.delete_message("test_queue", pop_receipt)
      expect(response).to eq(true)
    end
  end
end
