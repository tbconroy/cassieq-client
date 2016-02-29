require "active_support/core_ext/hash/keys"
require "active_support/inflector"
require "time"

module Cassieq
  module Utils
    def underscore_and_symobolize_keys(data)
      transform_keys_in_structure(data) { |key| key.underscore.to_sym }
    end

    def camelize_and_stringify_keys(data)
      transform_keys_in_structure(data) { |key| key.to_s.camelize(:lower) }
    end

    def formated_time_now
      Time.now.utc.iso8601
    end

    private

    def transform_keys_in_structure(data)
      case data
      when Hash
        data.transform_keys { |key| yield(key) }
      when Array
        data.map do |hash|
          hash.transform_keys { |key| yield(key) }
        end
      end
    end
  end
end 
