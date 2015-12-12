require 'spec_helper'

RSpec.describe Leggy::Exception, vcr: { cassette_name: 'leggy_exception', record: :none } do

  context ".errors" do

    before { Leggy.configuration.api_token = 'invalid' }

    after { Leggy.configuration.reset }

    it "raises a specific exception based on the error code" do
      expect{
        Leggy.crawls.all
      }.to raise_error Leggy::Exception::Unauthorized
    end

    it "allows any exception to be rescued from Leggy::Error" do
      expect{
        Leggy.crawls.all
      }.to raise_error Leggy::Error
    end

  end

end
