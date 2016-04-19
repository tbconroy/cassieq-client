require "cassieq/resource"

module Cassieq
  class Message < Cassieq::Resource
    attr_reader :pop_receipt
    attr_reader :message
    attr_reader :delivery_count
    attr_reader :message_tag
  end
end
