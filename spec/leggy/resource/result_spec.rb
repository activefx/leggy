require 'spec_helper'

RSpec.describe Leggy::Resource::Result do

  it "includes Leggy::ErrorHandler" do
    expect(described_class.ancestors).to include Leggy::ErrorHandler
  end

  context ".results" do

    let(:options) do
      {
        app: "HeaderData.js",
        max_depth: 1,
        max_urls: 10
      }
    end

    # If rerunning this test without a cassette, it needs to be run in stages
    # to allow for the crawl to finish and generate results
    #
    context ".all", vcr: { cassette_name: 'leggy_result', record: :none } do

      before do
        options.merge!(name: 'testing_crawl_results', urllist: 'sample_crawl_list')
        Leggy.urls.create(name: 'sample_crawl_list', body: fixture('urls.json'))
        Leggy.crawls.start(options)
      end

      after do
        Leggy.urls.delete(name: 'sample_crawl_list')
      end

      it "returns the s3 url of the results download" do
        results = Leggy.results.all(name: 'testing_crawl_results')
        expect(results.count).to be > 0
        results.each do |result|
          expect(result).to match Regexp.new(Regexp.escape("s3.amazonaws.com"))
        end
      end

    end

  end

end
