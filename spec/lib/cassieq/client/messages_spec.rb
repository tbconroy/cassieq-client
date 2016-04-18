require "spec_helper"

RSpec.describe Cassieq::Client::Messages do
  let(:client) { Cassieq::Client.new(host: CONFIG["host"], account: CONFIG["account"], key: CONFIG["key"] )}
  let(:publish_message) { client.publish_message("test_queue", "Test message!") }
  let(:next_message) { client.next_message("test_queue") }

  before(:each) { client.create_queue(queue_name: "test_queue") }
  after(:each) { client.delete_queue("test_queue") }
  
  describe "#publish_message", vcr: { cassette_name: "messages/publish_message" } do
    it "returns true" do
      expect(publish_message).to eq(true)
    end
  end

  describe "#next_message", vcr: { cassette_name: "messages/next_message" } do
    it "returns message" do
      publish_message
      expect(next_message).to have_attributes(message: "Test message!", delivery_count: 0, pop_receipt: /\w+/, message_tag: /\w+/)
    end
  end

  describe "#edit_message", vcr: { cassette_name: "messages/edit_message" } do
    let(:edit_message) { client.edit_message("test_queue", next_message[:pop_receipt], message: "Tacos tonight!") }

    it "returns information about the message" do
      publish_message
      expect(edit_message).to have_attributes(pop_receipt: /\w+/, message_tag: /\w+/)
    end 
  end

  describe "#ack_message", vcr: { cassette_name: "messages/ack_message" } do
    let(:ack_message) { client.ack_message("test_queue", next_message[:pop_receipt]) }

    it "returns true" do
      publish_message
      expect(ack_message).to eq(true)
    end
  end
end
