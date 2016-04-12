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
    include Cassieq::Utils

    attr_accessor :host, :account, :port, :key, :provided_params

    def initialize(params = {})
      @host = params[:host]
      @key = params[:key]
      @provided_params = params[:provided_params]
      @account = params[:account]
      @port = params.fetch(:port, 8080)
      yield(self) if block_given?
    end

    private

    def connection
      Faraday.new do |conn|
        conn.request(:url_encoded)
        conn.adapter(Faraday.default_adapter)
        conn.host = host
        conn.port = port
        conn.params.merge_query(provided_params) unless provided_params.nil?
        conn.response :json, :content_type => /\bjson$/
      end
    end

    def path_prefix
      "/api/v1/accounts/#{account}"
    end

    def request_path(path)
      "#{path_prefix}/#{path}"
    end

    def request(method, path, body = nil, params = nil)
      handle_response do
        path = request_path(path)
        auth_headers = generate_auth_headers(method, path)
        connection.run_request(method, path, body, auth_headers) do |req|
          req.params.merge!(params) unless params.nil?
          req.headers["Content-Type"] = "application/json" unless body.nil?
        end
      end
    end

    def generate_auth_headers(method, path)
      unless key.nil?
        Cassieq::Authentication.generate_auth_headers(key, account, method, path)
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
