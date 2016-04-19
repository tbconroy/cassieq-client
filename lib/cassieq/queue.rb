require "cassieq/resource"

module Cassieq
  class Queue < Cassieq::Resource
    attr_reader :account_name
    attr_reader :queue_name
    attr_reader :bucket_size
    attr_reader :max_delivery_count
    attr_reader :status
    attr_reader :version
    attr_reader :repair_worker_poll_frequency_seconds
    attr_reader :repair_worker_tombstoned_bucket_timeout_seconds
    attr_reader :delete_buckets_after_finalization
    attr_reader :queue_stats_id
    attr_reader :dlq_name
    attr_reader :strict_fifo
    attr_reader :id
  end
end
