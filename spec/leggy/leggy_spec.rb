require 'spec_helper'

RSpec.describe Leggy do

  before { Leggy.configuration.reset }

  it "must be defined" do
    expect(Leggy::VERSION).not_to be_nil
  end

  it "encodes api tokens" do
    Leggy.configuration.api_token = '1234'
    expect(Leggy.api_token).to eq "MTIzNDo=\n"
  end

end
