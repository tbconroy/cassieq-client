module Cassieq
  class Client
    module Statistics
      def statistics(queue_name)
        connection.get("queues/#{queue_name}/statistics")
      end
    end
  end 
end
