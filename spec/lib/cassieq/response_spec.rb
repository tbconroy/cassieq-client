require "spec_helper"

RSpec.describe Cassieq::Response do
  describe ".create_response" do
    let(:response) { Cassieq::Response.create_response(body) }

    context "body is an array of hashes" do
      let(:body) { [{ "firstAttribute" =>  "first" }, { "secondAttribute" =>  "second" }] }

      it "returns an array of response objects" do
        expect(response.first).to have_attributes(first_attribute: "first")
        expect(response.last).to have_attributes(second_attribute: "second") 
      end
    end

    context "body is a hash" do
      let(:body) { { "onlyAttribute" =>  "first" } }

      it "returns a response object" do
        expect(response).to have_attributes(only_attribute: "first")
      end
    end

    context "body not an array or hash" do
      let(:body) { "What" }

      it "raises" do
        expect do
          Cassieq::Response.create_response(body)
        end.to raise_error(TypeError, "Expected a Hash or Array, got a String")
      end
    end
  end
end
