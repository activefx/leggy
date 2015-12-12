require 'faraday'
require 'faraday_middleware'

module Helpers

  def get(url)
    Faraday.get(url).body
  end

  def post(*args)
    Faraday.post(*args).body
  end

  def fixtures(file_name)
    File.expand_path("../fixtures/#{file_name}", File.dirname(__FILE__))
  end

  def fixture(file_name)
    File.read(fixtures(file_name))
  end

end

RSpec.configure do |config|
  config.include Helpers
end
