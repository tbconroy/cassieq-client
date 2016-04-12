require "base64"
require "openssl"
require "time"

module Cassieq
  class Authentication
    attr_reader :key, :account

    def self.generate_auth_headers(key, account, method, path)
      new(key, account).auth_headers(method, path)
    end

    def initialize(key, account)
      @key = key
      @account = account
    end

    def auth_headers(method, path, request_time = formated_time_now)
      auth_signature = signature_from_key(method, path, request_time)

      { "X-Cassieq-Request-Time" => request_time, "Authorization" => "Signed #{auth_signature}" }
    end

    def signature_from_key(method, path, request_time = formated_time_now)
      key_bytes = Base64.urlsafe_decode64("#{key}==")
      string_to_sign = [account, method.to_s.upcase, path, request_time].join("\n")
      hmac = OpenSSL::HMAC.digest("sha256", key_bytes, string_to_sign)
      Base64.urlsafe_encode64(hmac).gsub(/=+$/, "")
    end

    private

    def formated_time_now
      Time.now.utc.iso8601
    end
  end
end
