require "spec_helper"
include Cassieq::Authentication

RSpec.describe Cassieq::Authentication do
  describe "#generate_signature_from_key" do
    it "return the key auth signature" do
      key = "xd2n0qw-keZHXsy5UblPH0zrxOPM0IknKLOkI98RhCLrdZ_AR1dh5ioZUT5kHc1lm3964l2rLLsSAsFun_l5qA"
      account = "test-account"
      request_method = "POST"
      request_path = "/api/v1/accounts/test-account/queues"
      request_time = "2016-02-28T21:57:33Z"
      signature = "YIQK5HX8G8iYh_8rHaDAeKR-bHBSszzzwmtP_VbWqGM"

      result = generate_signature_from_key(key, request_method, account, request_path, request_time)
      expect(result).to eq(signature)
    end
  end
end
