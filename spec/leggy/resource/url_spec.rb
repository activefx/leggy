require 'spec_helper'

RSpec.describe Leggy::Resource::Url, vcr: { cassette_name: 'leggy_url', record: :none } do

  it "includes Leggy::ErrorHandler" do
    expect(described_class.ancestors).to include Leggy::ErrorHandler
  end

  context ".urls" do

    context ".all" do

      before(:each) { Leggy.urls.create(name: 'sample_all', body: fixture('urls.json')) }
      after(:each) { Leggy.urls.delete(name: 'sample_all') }

      it "returns a list of all url lists" do
        urls = Leggy.urls.all
        expect(urls.collect(&:name)).to include 'sample_all'
      end

    end

    context ".create" do

      after(:each) { Leggy.urls.delete(name: 'sample') }

      it "uploads a new url list" do
        url = Leggy.urls.create(name: 'sample', body: fixture('urls.json'))
        expect(url).to be_truthy
      end

    end

    context ".find" do

      before(:each) { Leggy.urls.create(name: 'sample_find', body: fixture('urls.json')) }
      after(:each) { Leggy.urls.delete(name: 'sample_find') }

      it "returns a single url list" do
        url = Leggy.urls.find(name: 'sample_find')
        expect(url).to include 'http://example.com'
      end

    end

    context ".delete" do

      before(:each) { Leggy.urls.create(name: 'sample_delete', body: fixture('urls.json')) }

      it "removes an url list" do
        url = Leggy.urls.delete(name: 'sample_delete')
        expect(url).to be_truthy
      end

    end

  end

end
