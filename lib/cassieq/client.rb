require "faraday"
require "cassieq/client/queues"
require "cassieq/client/messages"
require "cassieq/client/statistics"

module Cassieq
  class Client
    include Cassieq::Client::Queues
    include Cassieq::Client::Messages
    include Cassieq::Client::Statistics

    attr_accessor :host, :account, :port, :key, :auth, :sig

    def initialize(params)
      @host = params.fetch(:host, nil)
      @key = params.fetch(:key, nil)
      @auth = params.fetch(:auth, nil)
      @sig = params.fetch(:sig, nil)
      @account = params.fetch(:account, nil)
      @port = params.fetch(:port, 8080)
    end

    def path_prefix
      "/api/v1/accounts/#{account}"
    end

    def connection
      Faraday.new do |faraday|
        faraday.request(:url_encoded)
        # faraday.response(:logger)
        faraday.adapter(Faraday.default_adapter)
      end.tap { |conn| configure_connection(conn) }
    end

    private

    def configure_connection(conn)
      conn.host = host
      conn.port = port
      conn.path_prefix = path_prefix
      conn.headers["Authorization"] = "Key #{key}" unless key.nil?
      unless auth.nil? || sig.nil?
        conn.params["auth"] = auth
        conn.params["sig"] = sig
      end
    end
  end
end
