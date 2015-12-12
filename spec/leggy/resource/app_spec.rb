require 'spec_helper'

RSpec.describe Leggy::Resource::App, vcr: { cassette_name: 'leggy_app', record: :none } do

  it "includes Leggy::ErrorHandler" do
    expect(described_class.ancestors).to include Leggy::ErrorHandler
  end

  context ".apps" do

    context ".all" do

      before(:each) do
        Leggy.apps.create(name: 'sample_all', body: fixture('sample_app.js'))
      end

      after(:each) do
        Leggy.apps.delete(name: 'sample_all')
      end

      it "returns a list of all apps" do
        apps = Leggy.apps.all
        expect(apps.collect(&:name)).to include 'sample_all'
      end

    end

    context ".create" do

      after(:each) { Leggy.apps.delete(name: 'sample') }

      it "uploads a new app" do
        app = Leggy.apps.create(name: 'sample', body: fixture('sample_app.js'))
        expect(app).to be_truthy
      end

    end

    context ".find" do

      before(:each) { Leggy.apps.create(name: 'sample_find', body: fixture('sample_app.js')) }
      after(:each) { Leggy.apps.delete(name: 'sample_find') }

      it "returns a single app" do
        app = Leggy.apps.find(name: 'sample_find')
        expect(app).to match /\A\/\//
      end

    end

    context ".delete" do

      before(:each) { Leggy.apps.create(name: 'sample_delete', body: fixture('sample_app.js')) }

      it "removes an app" do
        app = Leggy.apps.delete(name: 'sample_delete')
        expect(app).to be_truthy
      end

    end

  end

end
