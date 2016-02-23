require "spec_helper"
include Cassieq::Utils

RSpec.describe Cassieq::Utils do
  describe "#underscore_and_symobolize_keys" do
    context "structure is a single hash" do
      it "transforms the keys" do
        data = { "joeCamelCase" => "what", "ninjaTurtles" => "cowabunga" }
        expect(underscore_and_symobolize_keys(data)).to eq(joe_camel_case: "what", ninja_turtles: "cowabunga")
      end
    end

    context "structure is hashes nested in an array" do
      it "transforms the keys" do
        data = [{ "joeCamelCase" => "what" }, { "ninjaTurtles" => "cowabunga" }]
        expect(underscore_and_symobolize_keys(data)).to eq([{ joe_camel_case: "what" }, { ninja_turtles: "cowabunga" }])
      end
    end
  end

  describe "#camelize_and_stringify_keys" do
    context "structure is a single hash" do
      it "transforms the keys" do
        data = { :joe_camel_case => "what", :ninja_turtles => "cowabunga" }
        expect(camelize_and_stringify_keys(data)).to eq("joeCamelCase" => "what", "ninjaTurtles" => "cowabunga")
      end
    end

    context "structure is hashes nested in an array" do
      it "transforms the keys" do
        data = [{ :joe_camel_case => "what" }, { :ninja_turtles => "cowabunga" }]
        expect(camelize_and_stringify_keys(data)).to eq([{ "joeCamelCase" => "what" }, { "ninjaTurtles" => "cowabunga" }])
      end
    end
  end
end
