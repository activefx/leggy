module Leggy
  module Resource
    class Result < ResourceKit::Resource
      include Leggy::ErrorHandler

      resources do

        # GET https://api_token:@api.80legs.com/v2/results/{CRAWL_NAME}
        #
        action :all do
          verb :get
          path '/v2/results/:name'
          handler(200) { |response| JSON.parse(response.body) }
        end

      end

    end
  end
end
