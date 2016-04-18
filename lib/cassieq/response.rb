require "cassieq/utils"

module Cassieq
  class Response < OpenStruct
    include Cassieq::Utils

    def self.create_response(body)
      case body
      when Hash
        new(body)
      when Array
        body.map { |item| new(item) }
      else
        raise TypeError, "Expected a Hash or Array, got a #{body.class}"
      end
    end

    def initialize(body)
      super(Cassieq::Utils.underscore_and_symobolize_keys(body))
    end
  end
end
