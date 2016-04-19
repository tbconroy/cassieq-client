require "spec_helper"

RSpec.describe Cassieq::Queue do
  describe "initialization" do
    it "creates a queue object" do
      attributes = {
        account_name: "Great",
        queue_name: "Line",
        bucket_size: 25,
        max_delivery_count: 5,
        status: "Active",
        version: "n64",
        repair_worker_poll_frequency_seconds: 5,
        repair_worker_tombstoned_bucket_timeout_seconds: 15,
        delete_buckets_after_finalization: 666,
        queue_stats_id: "asdfa",
        dlq_name: "Name",
        strict_fifo: "Good",
        id: "adsfasdf",
      }
      queue = Cassieq::Queue.new(attributes)
      expect(queue).to have_attributes(attributes)
    end
  end
end
