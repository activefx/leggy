module Leggy
  module Resource
    class Url < ResourceKit::Resource
      include Leggy::ErrorHandler

      resources do

        # GET https://api_token:@api.80legs.com/v2/urllists
        #
        action :all do
          verb :get
          path '/v2/urllists'
          handler(200) { |response| Leggy::Mapping::Url.extract_collection(response.body, :read) }
        end

        # PUT https://api_token:@api.80legs.com/v2/urllists/{URLS_NAME}
        #
        action :create do
          before_request :set_content_type_for_uploads
          verb :put
          path '/v2/urllists/:name'
          body { |object| File.file?(object[:body]) ? File.read(object[:body]) : object[:body] }
          handler(204) { |response| true }
        end

        # GET https://api_token:@api.80legs.com/v2/urllists/{URLS_NAME}
        #
        action :find do
          verb :get
          path '/v2/urllists/:name'
          handler(200) { |response| JSON.parse(response.body) }
        end

        # DELETE https://api_token:@api.80legs.com/v2/urllists/{URLS_NAME}
        #
        action :delete do
          verb :delete
          path '/v2/urllists/:name'
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
