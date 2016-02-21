require "spec_helper"

RSpec.describe Cassieq::Utils do
  describe ".transform_keys" do
    it "symbolizes and underscores hash keys" do
      data = { "joeCamelCase" => "what", "ninjaTurtles" => "cowabunga" }
      transformed = Cassieq::Utils.transform_keys(data)
      expect(transformed).to eq({ joe_camel_case: "what", ninja_turtles: "cowabunga" })
    end

    it "symbolizes and undercores hash keys in an array" do
      data = [{ "joeCamelCase" => "what"} , {"ninjaTurtles" => "cowabunga" }]
      transformed = Cassieq::Utils.transform_keys(data)
      expect(transformed).to eq([{ joe_camel_case: "what"} , { ninja_turtles: "cowabunga" }])
    end
  end
end
