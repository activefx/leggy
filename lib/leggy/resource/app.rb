module Leggy
  module Resource
    class App < ResourceKit::Resource
      include Leggy::ErrorHandler

      resources do

        # GET https://api_token:@api.80legs.com/v2/apps
        #
        action :all do
          verb :get
          path '/v2/apps'
          handler(200) { |response| Leggy::Mapping::App.extract_collection(response.body, :read) }
        end

        # PUT https://api_token:@api.80legs.com/v2/apps/{APP_NAME}
        #
        action :create do
          before_request :set_content_type_for_uploads
          verb :put
          path '/v2/apps/:name'
          body { |object| File.file?(object[:body]) ? File.read(object[:body]) : object[:body] }
          handler(204) { |response| true }
        end

        # GET https://api_token:@api.80legs.com/v2/apps/{APP_NAME}
        #
        action :find do
          verb :get
          path '/v2/apps/:name'
          handler(200) { |response| response.body }
        end

        # DELETE https://api_token:@api.80legs.com/v2/apps/{APP_NAME}
        #
        action :delete do
          verb :delete
          path '/v2/apps/:name'
          handler(204) { |response| true }
        end

      end

      private

      def set_content_type_for_uploads(*args, request)
        request.headers['Content-Type'] = 'application/octet-stream'
      end

    end
  end
end
