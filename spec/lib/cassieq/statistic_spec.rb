require "spec_helper"

RSpec.describe Cassieq::Statistic do
  describe "initialization" do
    it "creates a statistic object" do
      attributes = { size: 999 }
      statistic = Cassieq::Statistic.new(attributes)
      expect(statistic).to have_attributes(attributes)
    end
  end
end
