# 400 Bad Request Often times a missing or incorrect parameter
# 401 Unauthorized  Invalid/Missing API Token
# 404 Not Found Using an invalid API end point, or the user supplied path is incorrect
# 422 Unprocessable Entity  All the parameters were correct but the request was rejected on the back end, contact support with request information
# 523 Service Unavailable The API is currently unavailable due to maitenance, try again later.
# 5xx Server Error  There was an error within the Datafiniti servers
#
require 'leggy/error'

module Leggy
  module Exception
    class BadRequest < Leggy::Error
    end

    class Unauthorized < Leggy::Error
    end

    class NotFound < Leggy::Error
    end

    class UnprocessableEntity < Leggy::Error
    end

    class ServiceUnavailable < Leggy::Error
    end

    class ServerError < Leggy::Error
    end
  end
end
