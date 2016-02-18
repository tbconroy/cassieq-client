module Cassieq
  class Client
    module Messages
      def create_message(queue_name, message)
        post("queues/#{queue_name}/messages", message)
      end

      def next_message(queue_name)
        get("queues/#{queue_name}/messages/next")
      end

      def edit_message(queue_name, pop_receipt, options)
        put("queues/#{queue_name}/messages", options.to_json, { popReceipt: pop_receipt })
      end

      def delete_message(queue_name, pop_receipt)
        delete("queues/#{queue_name}/messages", popReceipt: pop_receipt)
      end
    end
  end 
end
