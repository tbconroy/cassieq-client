require "spec_helper"

RSpec.describe Cassieq::Error do
  describe ".from_status_and_body" do
    let(:response) { double("response", status: status, body: { "message" => "Really bad thing" }) }

    context "when response is not a success" do
      let(:status) { 400 }

      it "raises" do
        expect{ Cassieq::Error.from_status_and_body(response) }.to raise_error(Cassieq::ClientError, "Really bad thing")
      end
    end

    context "when the response is a success" do
      let(:status) { 200 }

      it "does not raise" do
        expect{ Cassieq::Error.from_status_and_body(response) }.not_to raise_error
      end
    end
  end
end
