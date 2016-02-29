require "faraday"
require "faraday_middleware"
require "cassieq/authentication"
require "cassieq/client/messages"
require "cassieq/client/statistics"
require "cassieq/client/queues"
require "cassieq/error"
require "cassieq/utils"

module Cassieq
  class Client
    include Cassieq::Client::Queues
    include Cassieq::Client::Messages
    include Cassieq::Client::Statistics
    include Cassieq::Authentication
    include Cassieq::Utils

    attr_accessor :host, :account, :port, :key, :provided_params

    def initialize(params = {})
      @host = params.fetch(:host, nil)
      @key = params.fetch(:key, nil)
      @provided_params = params.fetch(:provided_params, nil)
      @account = params.fetch(:account, nil)
      @port = params.fetch(:port, 8080)
      yield(self) if block_given?
    end

    private

    def path_prefix
      "/api/v1/accounts/#{account}"
    end

    def connection
      Faraday.new do |conn|
        conn.request(:url_encoded)
        conn.adapter(Faraday.default_adapter)
        conn.host = host
        conn.port = port
        conn.path_prefix = path_prefix
        conn.params.merge_query(provided_params) unless provided_params.nil?
        conn.response :json, :content_type => /\bjson$/
      end
    end

    def request(method, path, body = nil, params = nil)
      handle_response do
        auth_headers = generate_auth_headers(method, path)
        connection.run_request(method, path, body, auth_headers) do |req|
          req.params.merge!(params) unless params.nil?
          req.headers["Content-Type"] = "application/json" unless body.nil?
        end
      end
    end

    def generate_auth_headers(method, path)
      unless key.nil?
        request_time = formated_time_now
        request_path = "#{path_prefix}/#{path}"
        auth_signature = generate_signature_from_key(key, method.to_s.upcase, account, request_path, request_time)

        { "X-Cassieq-Request-Time" => request_time, "Authorization" => "Signed #{auth_signature}" }
      else
        nil
      end
    end

    def handle_response(&request_block)
      response = request_block.call
      Cassieq::Error.from_status_and_body(response)
      unless response.body.empty?
        underscore_and_symobolize_keys(response.body)
      else
        true
      end
    end
  end
end
