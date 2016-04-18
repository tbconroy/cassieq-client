require "cassieq/utils"
require "json"

module Cassieq
  class Client
    module Messages
      include Cassieq::Utils

      def publish_message(queue_name, message)
        request(:post, "queues/#{queue_name}/messages", message)
      end

      def next_message(queue_name)
        request(:get, "queues/#{queue_name}/messages/next")
      end

      def edit_message(queue_name, pop_receipt, options)
        body = Cassieq::Utils.camelize_and_stringify_keys(options).to_json
        params = { popReceipt: pop_receipt }
        request(:put, "queues/#{queue_name}/messages", body, params)
      end

      def ack_message(queue_name, pop_receipt)
        params = { popReceipt: pop_receipt }
        request(:delete, "queues/#{queue_name}/messages", nil, params)
      end
    end
  end 
end
