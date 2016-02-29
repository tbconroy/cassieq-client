require "base64"
require "openssl"

module Cassieq
  module Authentication
    def generate_signature_from_key(key, request_method, account, request_path, request_time)
      key_bytes = Base64.urlsafe_decode64("#{key}==")
      string_to_sign = [account, request_method, request_path, request_time].join("\n")
      hmac = OpenSSL::HMAC.digest("sha256", key_bytes, string_to_sign)
      Base64.urlsafe_encode64(hmac).gsub(/=+$/, "")
    end
  end
end
