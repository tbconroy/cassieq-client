require "spec_helper"

RSpec.describe Cassieq::ResourceFactory do
  describe ".build" do
    let(:resource_class) { spy("Resource") }
    let(:build_resource) { Cassieq::ResourceFactory.build(resource_class, body) }

    context "body is an array of hashes" do
      let(:body) { [{ "firstAttribute" =>  "first" }, { "secondAttribute" =>  "second" }] }

      it "instantiates an array of resource objects" do
        build_resource
        expect(resource_class).to have_received(:new).with(first_attribute: "first")
        expect(resource_class).to have_received(:new).with(second_attribute: "second") 
      end
    end

    context "body is a hash" do
      let(:body) { { "onlyAttribute" =>  "first" } }

      it "instantiates a resource object" do
        build_resource
        expect(resource_class).to have_received(:new).with(only_attribute: "first")
      end
    end

    context "body not an array or hash" do
      let(:body) { "What" }

      it "raises" do
        expect { build_resource }.to raise_error(TypeError, "Expected a Hash or Array, got a String")
      end
    end
  end
end
