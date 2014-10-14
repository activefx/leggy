module Leggy
  module Resource
    class Crawl < ResourceKit::Resource

      resources do

        default_handler do |response|
          raise "ERROR #{response.status}: #{response.body}"
        end

        # POST https://api_token:@api.80legs.com/v2/crawls/{CRAWL_NAME}
        #
        action :start do
          verb :post
          path '/v2/crawls/:name'
          body { |object| object.slice(*Leggy::CrawlOptions.attr_accessors).to_json }
          handler(204) { |response| true }
        end

        # GET https://api_token:@api.80legs.com/v2/crawls/{CRAWL_NAME}
        #
        action :status do
          verb :get
          path '/v2/crawls/:name'
          handler(200) { |response| Leggy::Mapping::Crawl.extract_single(response.body, :read) }
        end

        # DELETE https://api_token:@api.80legs.com/v2/crawls/{CRAWL_NAME}
        #
        action :cancel do
          verb :delete
          path '/v2/crawls/:name'
          handler(204) { |response| true }
        end

        # GET https://api_token:@api.80legs.com/v2/results/{CRAWL_NAME}
        #
        action :results do
          verb :get
          path '/v2/results/:name'
          handler(200) { |response| JSON.parse(response.body) }
        end

      end

    end
  end
end

