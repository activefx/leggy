require "leggy/version"
require "dotenv"
require "gem_config"
require "kartograph"
require "resource_kit"
require "faraday_middleware"
require "base64"
require "active_support/concern"
require "active_support/core_ext/hash/slice"
require "ostruct"

require "leggy/helpers"
require "leggy/user"
require "leggy/app"
require "leggy/url"
require "leggy/crawl_options"
require "leggy/crawl"
require "leggy/mapping/user"
require "leggy/mapping/app"
require "leggy/mapping/url"
require "leggy/mapping/crawl_options"
require "leggy/mapping/crawl"
require "leggy/resource/user"
require "leggy/resource/app"
require "leggy/resource/url"
require "leggy/resource/crawl"

Dotenv.load

module Leggy
  include GemConfig::Base

  with_configuration do
    has :api_token,     classes: String,  default: ENV['80_LEGS_API_TOKEN']
  end

  def self.api_token
    Base64.encode64("#{configuration.api_token}:")
  end

  def self.connection=(value)
    @connection = value
  end

  def self.connection
    @connection ||= Faraday.new(
      url: 'https://api.80legs.com',
      headers: {
        content_type: 'application/json',
        authorization: "Basic #{api_token}"
      }
    ) do |req|
      req.adapter :net_http
    end
  end

  # This resource allows for the viewing of user data.
  #
  def self.users(options = {})
    Leggy::Resource::User.new(setup(options))
  end

  # This resource allows for the uploading of 80app files.
  #
  def self.apps(options = {})
    Leggy::Resource::App.new(setup(options))
  end

  # This resource allows for the uploading and viewing of URL lists.
  #
  def self.urls(options = {})
    Leggy::Resource::Url.new(setup(options))
  end

  # This resource allows for the creation and cancelation of crawls. It also allows
  # the user to view the crawl status and settings. When the crawl is complete the
  # links of the results will also be provided within the crawl.
  #
  def self.crawls(options = {})
    Leggy::Resource::Crawl.new(setup(options))
  end

  def self.setup(options)
    options[:connection] = connection unless options[:connection]
    options
  end

end

