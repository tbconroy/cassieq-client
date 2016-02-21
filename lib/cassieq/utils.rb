module Cassieq
  class Utils

    class << self

      def transform_keys(data)
        case data
        when Hash
          underscore_and_symbolize_keys(data)
        when Array
          data.map! { |hash| underscore_and_symbolize_keys(hash) }
        end
      end

      private

      def underscore_and_symbolize_keys(hash)
        Hash[hash.map{ |key, value| [underscore(key).to_sym, value] }]
      end

      def underscore(string)
        string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end
    end
  end
end
