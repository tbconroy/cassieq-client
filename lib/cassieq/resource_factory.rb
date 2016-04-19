require "cassieq/utils"

module Cassieq
  class ResourceFactory
    include Cassieq::Utils

    def self.build(resource_class, response_body)
      case response_body
      when Hash
        build_resource_object(resource_class, response_body)
      when Array
        response_body.map { |item| build_resource_object(resource_class, item) }
      else
        raise TypeError, "Expected a Hash or Array, got a #{response_body.class}"
      end
    end

    private

    def self.build_resource_object(resource_class, response_body)
      transformed_body = Cassieq::Utils.underscore_and_symobolize_keys(response_body)
      resource_class.new(transformed_body)
    end
  end
end
