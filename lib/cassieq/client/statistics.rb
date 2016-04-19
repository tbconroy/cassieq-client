require "cassieq/statistic"

module Cassieq
  class Client
    module Statistics
      def statistics(queue_name)
        request(:get, Cassieq::Statistic, "queues/#{queue_name}/statistics")
      end
    end
  end 
end
