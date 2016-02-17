module Cassieq
  class Client
    module Queues
      def queues
        connection.get("queues")
      end

      def create_queue(options)
        connection.post("queues") do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = options.to_json
        end
      end

      def queue(queue_name)
        connection.get("queues/#{queue_name}")
      end

      def delete_queue(queue_name)
        connection.delete("queues/#{queue_name}")
      end
    end
  end 
end
