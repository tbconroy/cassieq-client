module Cassieq
  class Error < StandardError

    def self.check_response(response)
      error = case response.status.to_i
        when 401
          Cassieq::Unauthorized
        when 404
          Cassieq::NotFound
        when 409
          Cassieq::Conflict
        when 400..499
          Cassieq::ClientError
        when 500..599
          Cassieq::ServerError
        end
      raise error, response.body if error
    end
  end

  #400-499
  class ClientError < Error; end

  #404
  class NotFound < ClientError; end

  #409
  class Conflict < ClientError; end

  #401
  class Unauthorized < ClientError; end

  #500-599
  class ServerError < Error; end
end
