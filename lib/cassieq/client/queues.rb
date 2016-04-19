require "cassieq/queue"
require "cassieq/utils"
require "json"

module Cassieq
  class Client
    module Queues
      include Cassieq::Utils

      def queues
        request(:get, Cassieq::Queue, "queues")
      end

      def create_queue(options)
        body = Cassieq::Utils.camelize_and_stringify_keys(options).to_json
        request(:post, nil, "queues", body)
      end

      def queue(queue_name)
        request(:get, Cassieq::Queue, "queues/#{queue_name}")
      end

      def delete_queue(queue_name)
        request(:delete, nil, "queues/#{queue_name}")
      end
    end
  end 
end
