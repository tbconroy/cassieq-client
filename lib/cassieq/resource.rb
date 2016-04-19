module Cassieq
  class Resource
    attr_reader :attributes

    class << self
      def attr_reader(*attrs)
        attrs.each { |attr| define_attribute_method(attr) }
      end

      private

      def define_attribute_method(method)
        define_method(method) do
          instance_variable_set(:"@#{method}", @attributes[method])
        end
      end
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    def [](method)
      send(method.to_sym)
    rescue NoMethodError
      nil
    end

    def inspect
      "#<#{self.class.name}:#{self.object_id}>"
    end
  end
end
