require 'spec_helper'

describe Leggy, vcr: { cassette_name: 'leggy' } do

  before { Leggy.configuration.reset }

  it "must be defined" do
    expect(Leggy::VERSION).not_to be_nil
  end

  it "encodes api tokens" do
    Leggy.configuration.api_token = '1234'
    expect(Leggy.api_token).to eq "MTIzNDo=\n"
  end

  context "Users" do

    context "#find" do

      it "returns a single user" do
        user = Leggy.users.find(api_token: Leggy.configuration.api_token)
        expect(user.first_name).to eq 'Matt'
      end

    end

  end

  context "Apps" do

    context "#all" do

      before(:each) { Leggy.apps.create(name: 'sample_all', body: fixture('sample_app.js')) }
      after(:each) { Leggy.apps.delete(name: 'sample_all') }

      it "returns a list of all apps" do
        apps = Leggy.apps.all
        expect(apps.collect(&:name)).to include 'sample_all'
      end

    end

    context "#create" do

      after(:each) { Leggy.apps.delete(name: 'sample') }

      it "uploads a new app" do
        app = Leggy.apps.create(name: 'sample', body: fixture('sample_app.js'))
        expect(app).to be_truthy
      end

    end

    context "#find" do

      before(:each) { Leggy.apps.create(name: 'sample_find', body: fixture('sample_app.js')) }
      after(:each) { Leggy.apps.delete(name: 'sample_find') }

      it "returns a single app" do
        app = Leggy.apps.find(name: 'sample_find')
        expect(app).to match /\A\/\//
      end

    end

    context "#delete" do

      before(:each) { Leggy.apps.create(name: 'sample_delete', body: fixture('sample_app.js')) }

      it "removes an app" do
        app = Leggy.apps.delete(name: 'sample_delete')
        expect(app).to be_truthy
      end

    end

  end

  context "Urls" do

    context "#all" do

      before(:each) { Leggy.urls.create(name: 'sample_all', body: fixture('urls.json')) }
      after(:each) { Leggy.urls.delete(name: 'sample_all') }

      it "returns a list of all url lists" do
        urls = Leggy.urls.all
        expect(urls.collect(&:name)).to include 'sample_all'
      end

    end

    context "#create" do

      after(:each) { Leggy.urls.delete(name: 'sample') }

      it "uploads a new url list" do
        url = Leggy.urls.create(name: 'sample', body: fixture('urls.json'))
        expect(url).to be_truthy
      end

    end

    context "#find" do

      before(:each) { Leggy.urls.create(name: 'sample_find', body: fixture('urls.json')) }
      after(:each) { Leggy.urls.delete(name: 'sample_find') }

      it "returns a single url list" do
        url = Leggy.urls.find(name: 'sample_find')
        expect(url).to include 'http://example.com'
      end

    end

    context "#delete" do

      before(:each) { Leggy.urls.create(name: 'sample_delete', body: fixture('urls.json')) }

      it "removes an url list" do
        url = Leggy.urls.delete(name: 'sample_delete')
        expect(url).to be_truthy
      end

    end

  end

  context "Urls" do

    let(:options) do
      {
        name: "start_crawl",
        app: "HeaderData.js",
        urllist: "1",
        max_depth: 2,
        max_urls: 1000
      }
    end

    context "#start" do

      after(:each) { Leggy.crawls.cancel(name: "start_crawl") }

      it "starts a new crawl" do
        crawl = Leggy.crawls.start(options)
        expect(crawl).to be_truthy
      end

    end

    context "#status" do

      before(:each) { Leggy.crawls.start(options.merge(name: "status_crawl")) }
      after(:each) { Leggy.crawls.cancel(name: "status_crawl")  }

      it "uploads a new url list" do
        crawl = Leggy.crawls.status(name: "status_crawl")
        expect(crawl.status).to eq 'QUEUED'
      end

    end

    context "#cancel" do

      before(:each) { Leggy.crawls.start(options.merge(name: "cancel_crawl")) }

      it "returns a single url list" do
        crawl = Leggy.crawls.cancel(name: "cancel_crawl")
        expect(crawl).to be_truthy
      end

    end

  end

end
