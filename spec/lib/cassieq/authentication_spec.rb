require "spec_helper"

RSpec.describe Cassieq::Authentication do
  let(:authentication) do
    key = "cN706OCyyDSzx03gju35TG2wVKCDyMx-_2s_Dcu9TVIDQif-iGKNYv0P3Gi2OffXlB4zpVx-GYaHBucrIY9vYw"
    Cassieq::Authentication.new(key, "test-account")
  end
  let(:time) { "2016-04-11T21:27:59Z" }
  let(:method) { :get }
  let(:path) { "/queues/test_queue/messages/next" }
  let(:expected_signature) { "LlK-olMhrBbSaUAir_kDJZUtlVWx1qkOp-APecO3wlM" }

  describe "#signature_from_key" do
    it "returns the auth signature" do
      expect(authentication.signature_from_key(method, path, time)).to eq(expected_signature)
    end
  end

  describe "#auth_headers" do
    it "return the auth header in a hash" do
      expected_header = { "X-Cassieq-Request-Time" => time, "Authorization" => "Signed #{expected_signature}" }
      expect(authentication.auth_headers(method, path, time)).to eq(expected_header)
    end
  end
end
