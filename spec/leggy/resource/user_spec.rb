require 'spec_helper'

RSpec.describe Leggy::Resource::User, vcr: { cassette_name: 'leggy_user', record: :none } do

  it "includes Leggy::ErrorHandler" do
    expect(described_class.ancestors).to include Leggy::ErrorHandler
  end

  context ".users" do

    context ".find" do

      it "returns a single user" do
        user = Leggy.users.find(api_token: Leggy.configuration.api_token)
        expect(user.first_name).to eq 'Matt'
      end

    end

  end

end
