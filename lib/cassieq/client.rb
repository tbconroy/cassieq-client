require "faraday"
require "faraday_middleware"
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

    attr_accessor :host, :account, :port, :key, :auth, :sig

    def initialize(params)
      @host = params.fetch(:host, nil)
      @key = params.fetch(:key, nil)
      @auth = params.fetch(:auth, nil)
      @sig = params.fetch(:sig, nil)
      @account = params.fetch(:account, nil)
      @port = params.fetch(:port, 8080)
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
        conn.headers["Authorization"] = "Key #{key}" unless key.nil?
        unless auth.nil? || sig.nil?
          conn.params["auth"] = auth
          conn.params["sig"] = sig
        end
        conn.response :json, :content_type => /\bjson$/
      end
    end

    def get(path)
      handle_response do
        connection.run_request(:get, path, nil, nil)
      end
    end

    def post(path, body)
      handle_response do
        connection.run_request(:post, path, body, nil) do |req|
          req.headers.merge!("Content-Type" => "application/json")
        end
      end
    end

    def put(path, body, params = {})
      handle_response do
        connection.run_request(:put, path, body, nil) do |req|
          req.params.merge!(params)
          req.headers.merge!("Content-Type" => "application/json")
        end
      end
    end

    def delete(path, params = {})
      handle_response do
        connection.run_request(:delete, path, nil, nil) do |req|
          req.params.merge!(params)
        end
      end
    end

    def handle_response(&request_block)
      response = request_block.call
      Cassieq::Error.from_status_and_body(response)
      unless response.body.nil? || response.body.empty?
        Cassieq::Utils.transform_keys(response.body)
      else
        true
      end
    end
  end
end
