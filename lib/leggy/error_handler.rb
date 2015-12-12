module Leggy
  module ErrorHandler

    def self.included(base)
      base.send(:resources) do

        default_handler do |response|
          case response.status
          when 200...299
            next
          when 400
            raise Leggy::Exception::BadRequest.new("#{response.status}: #{response.body}")
          when 401
            raise Leggy::Exception::Unauthorized.new("#{response.status}: #{response.body}")
          when 404
            raise Leggy::Exception::NotFound.new("#{response.status}: #{response.body}")
          when 422
            raise Leggy::Exception::UnprocessableEntity.new("#{response.status}: #{response.body}")
          when 523
            raise Leggy::Exception::ServiceUnavailable.new("#{response.status}: #{response.body}")
          else
            raise Leggy::Exception::ServerError.new("#{response.status}: #{response.body}")
          end
        end

      end
    end

  end
end
