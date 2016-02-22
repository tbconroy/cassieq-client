require "spec_helper"

RSpec.describe Cassieq::Client::Messages do
  let(:client) { Cassieq::Client.new(host: CONFIG["host"], account: "test", key: CONFIG["key"] )}
  let(:create_message) { client.create_message("test_queue", "Test message!") }
  let(:next_message) { client.next_message("test_queue") }

  before(:each) { client.create_queue(queueName: "test_queue") }
  after(:each) { client.delete_queue("test_queue") }
  
  describe "#create_message", vcr: { cassette_name: "messages/create_message" } do
    it "returns true" do
      expect(create_message).to eq(true)
    end
  end

  describe "#next_message", vcr: { cassette_name: "messages/next_message" } do
    it "returns message" do
      create_message
      expect(next_message.size).to be(4)
      expect(next_message[:message]).to eq("Test message!")
      expect(next_message[:delivery_count]).to eq(0)
      expect(next_message[:pop_receipt]).to match(/\w+/)
      expect(next_message[:message_tag]).to match(/\w+/)
    end
  end

  describe "#edit_message", vcr: { cassette_name: "messages/edit_message" } do
    let(:edit_message) { client.edit_message("test_queue", next_message[:pop_receipt], message: "Tacos tonight!") }

    it "returns information about the message" do
      create_message
      expect(edit_message.size).to be(2)
      expect(edit_message[:pop_receipt]).to match(/\w+/)
      expect(edit_message[:message_tag]).to match(/\w+/)
    end 
  end

  describe "#delete_message", vcr: { cassette_name: "messages/delete_message" } do
    let(:delete_message) { client.delete_message("test_queue", next_message[:pop_receipt]) }

    it "returns true" do
      create_message
      expect(delete_message).to eq(true)
    end
  end
end
