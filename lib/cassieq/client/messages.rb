module Cassieq
  class Client
    module Messages
      def create_message(queue_name, message)
        connection.post("queues/#{queue_name}/messages") do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = message
        end
      end

      def next_message(queue_name)
        connection.get("queues/#{queue_name}/messages/next")
      end

      def edit_message(queue_name, pop_receipt, options)
        connection.put("queues/#{queue_name}/messages") do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = options.to_json
          req.params["popReceipt"] = pop_receipt
        end
      end

      def delete_message(queue_name, pop_receipt)
        connection.delete("queues/#{queue_name}/messages") do |req|
        req.params["popReceipt"] = pop_receipt
        end
      end
    end
  end 
end
