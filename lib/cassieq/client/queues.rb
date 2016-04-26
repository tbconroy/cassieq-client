require "json"

module Cassieq
  class Client
    module Queues
      def queues
        request(:get, "queues")
      end

      def create_queue(options, error_if_exists = nil)
        body = Cassieq::Utils.camelize_and_stringify_keys(options).to_json
        query = { errorIfExists: error_if_exists } unless error_if_exists.nil?
        request(:post, "queues", body, query)
      end

      def queue(queue_name)
        request(:get, "queues/#{queue_name}")
      end

      def delete_queue(queue_name)
        request(:delete, "queues/#{queue_name}")
      end
    end
  end 
end
