require "spec_helper"

RSpec.describe Cassieq::Message do
  describe "initialization" do
    it "creates a message object" do
      attributes = { message: "something", delivery_count: 666, pop_receipt: "cool", message_tag: "story" }
      message = Cassieq::Message.new(attributes)
      expect(message).to have_attributes(attributes)
    end
  end
end
