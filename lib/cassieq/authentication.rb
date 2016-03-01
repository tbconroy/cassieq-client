require "base64"
require "openssl"
require "time"

module Cassieq
  module Authentication
    private

    def generate_auth_headers(request_method, request_path)
      request_time = formated_time_now
      auth_signature = generate_signature_from_key(request_method.to_s.upcase, request_path, request_time)

      { "X-Cassieq-Request-Time" => request_time, "Authorization" => "Signed #{auth_signature}" }
    end

    def generate_signature_from_key(request_method, request_path, request_time)
      key_bytes = Base64.urlsafe_decode64("#{key}==")
      string_to_sign = [account, request_method, request_path, request_time].join("\n")
      hmac = OpenSSL::HMAC.digest("sha256", key_bytes, string_to_sign)
      Base64.urlsafe_encode64(hmac).gsub(/=+$/, "")
    end

    def formated_time_now
      Time.now.utc.iso8601
    end
  end
end
