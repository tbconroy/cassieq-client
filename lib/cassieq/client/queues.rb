module Cassieq
  class Client
    module Queues
      def queues
        get("queues")
      end

      def create_queue(options)
        post("queues", options.to_json)
      end

      def queue(queue_name)
        get("queues/#{queue_name}")
      end

      def delete_queue(queue_name)
        delete("queues/#{queue_name}")
      end
    end
  end 
end
