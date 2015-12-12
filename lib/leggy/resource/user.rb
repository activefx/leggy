module Leggy
  module Resource
    class User < ResourceKit::Resource
      include Leggy::ErrorHandler

      resources do

        # GET https://api_token:@api.80legs.com/v2/users/{USER_API_TOKEN}
        #
        action :find do
          verb :get
          path '/v2/users/:api_token'
          handler(200) { |response| Leggy::Mapping::User.extract_single(response.body, :read) }
        end

      end

    end
  end
end
