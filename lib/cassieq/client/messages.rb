require "json"

module Cassieq
  class Client
    module Messages
      def publish_message(queue_name, message, initial_invis_time = nil)
        query = { initialInvisibilityTime: initial_invis_time } unless initial_invis_time.nil?
        request(:post, "queues/#{queue_name}/messages", message, query)
      end

      def next_message(queue_name, initial_invis_time = nil)
        query = { initialInvisibilityTime: initial_invis_time } unless initial_invis_time.nil?
        request(:get, "queues/#{queue_name}/messages/next", nil, query)
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
