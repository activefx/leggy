require 'spec_helper'

RSpec.describe Leggy::Resource::Crawl do

  it "includes Leggy::ErrorHandler" do
    expect(described_class.ancestors).to include Leggy::ErrorHandler
  end

  context ".crawls" do

    let(:options) do
      {
        app: "HeaderData.js",
        max_depth: 1,
        max_urls: 10
      }
    end

    context ".all", vcr: { cassette_name: 'leggy_crawl_all', record: :none } do

      it "returns a list of all crawls" do
        crawls = Leggy.crawls.all
        expect(crawls).not_to be_empty
      end

    end

    context ".start", vcr: { cassette_name: 'leggy_crawl_start', record: :none } do

      before do
        options.merge!(name: 'testing_crawl_start', urllist: 'sample_crawl_list')
        Leggy.urls.create(name: 'sample_crawl_list', body: fixture('urls.json'))
      end

      after do
        Leggy.urls.delete(name: 'sample_crawl_list')
        Leggy.crawls.cancel(name: 'testing_crawl_start')
      end

      it "starts a new crawl" do
        crawl = Leggy.crawls.start(options)
        expect(crawl).to be_truthy
      end

    end

    context ".status", vcr: { cassette_name: 'leggy_crawl_status', record: :none } do

      before do
        options.merge!(name: 'testing_crawl_status', urllist: 'sample_crawl_list')
        Leggy.urls.create(name: 'sample_crawl_list', body: fixture('urls.json'))
        Leggy.crawls.start(options)
      end

      after do
        Leggy.urls.delete(name: 'sample_crawl_list')
        Leggy.crawls.cancel(name: 'testing_crawl_status')
      end

      it "uploads a new url list"  do
        crawl = Leggy.crawls.status(name: "testing_crawl_status")
        expect(crawl.status).to match /QUEUED|STARTED/
      end

    end

    context ".cancel", vcr: { cassette_name: 'leggy_crawl_cancel', record: :none } do

      before do
        options.merge!(name: 'testing_crawl_cancel', urllist: 'sample_crawl_list')
        Leggy.urls.create(name: 'sample_crawl_list', body: fixture('urls.json'))
        Leggy.crawls.start(options)
      end

      after do
        Leggy.urls.delete(name: 'sample_crawl_list')
      end

      it "returns a single url list" do
        crawl = Leggy.crawls.cancel(name: 'testing_crawl_cancel')
        expect(crawl).to be_truthy
      end

    end

  end

end
