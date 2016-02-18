module Cassieq
  class Client
    module Statistics
      def statistics(queue_name)
        get("queues/#{queue_name}/statistics")
      end
    end
  end 
end
