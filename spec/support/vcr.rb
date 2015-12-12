require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = File.join(File.dirname(__FILE__), '..', 'cassettes')
  c.hook_into :webmock #:typhoeus, :faraday, :fakeweb, or :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<TOKEN>') { Leggy.configuration.api_token }
  c.filter_sensitive_data('<BASE64_TOKEN>') { Leggy.api_token }
end
