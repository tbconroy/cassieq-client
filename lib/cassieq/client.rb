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

    def request(method, path, body = nil, params = {})
      request_path = "#{path_prefix}/#{path}"

      handle_response do
        connection.run_request(method, request_path, body, nil) do |req|
          req.params.merge!(params)
          req.headers.merge!(auth_headers(method, request_path)) unless key.nil?
          req.headers.merge!("Content-Type" => "application/json") unless body.nil?
        end
      end
    end

    def auth_headers(method, path)
      Cassieq::Authentication.generate_auth_headers(key, account, method, path)
    end

    def handle_response(&request_block)
      response = request_block.call
      Cassieq::Error.from_status_and_body(response)
      unless response.body.empty?
        Cassieq::Utils.underscore_and_symobolize_keys(response.body)
      else
        true
      end
    end
  end
end
