# Leggy

[![Gem Version](https://img.shields.io/gem/v/leggy.svg?style=flat)](https://rubygems.org/gems/leggy)
[![Build Status](https://img.shields.io/travis/activefx/leggy.svg?style=flat)](http://travis-ci.org/activefx/leggy)
[![Code Climate](https://img.shields.io/codeclimate/github/activefx/leggy.svg?style=flat)](https://codeclimate.com/github/activefx/leggy)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/activefx/leggy.svg?style=flat)](https://codeclimate.com/github/activefx/leggy/coverage)
[![Dependency Status](https://gemnasium.com/activefx/leggy.svg)](https://gemnasium.com/activefx/leggy)

Leggy is a simple Ruby wrapper for the 80Legs API. Sign up for a new account at [http://80legs.com/](http://80legs.com/) or view the API docs at [http://datafiniti.github.io/80docs/](http://datafiniti.github.io/80docs/). Leggy is built on top of [Resource Kit](https://github.com/digitalocean/resource_kit) and [Kartograph](https://github.com/digitalocean/kartograph) and accepts custom [Faraday](https://github.com/lostisland/faraday) connections.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leggy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leggy

## Usage

Before you can use the 80Legs client, you need to configure the API token. You can use the .configure method to do so: 

````ruby
Leggy.configure do |config|
  config.api_token = 'api_token'
end
````

Or you can set it as as the `80_LEGS_API_TOKEN` ENV variable: 

````
$ export 80_LEGS_API_TOKEN=your_80legs_api_token
````

Sign up for an account and API token at [80legs](http://80legs.com/).

### Users 

See [http://datafiniti.github.io/80docs/?ruby#users](http://datafiniti.github.io/80docs/?ruby#users) for complete documentation.

#### Get User Data

````ruby 
user = Leggy.users.find(api_token: Leggy.configuration.api_token)
user.first_name 
#=> "Matt" 
````

### Apps

See [http://datafiniti.github.io/80docs/?ruby#apps](http://datafiniti.github.io/80docs/?ruby#apps) for complete documentation.

#### Get All Apps

````ruby 
apps = apps = Leggy.apps.all
apps.first.name
#=> "TextFromURLListOnly.js"
````

#### Upload an App

````ruby 
file = File.read("/path/to/my/eighty_app.js")
Leggy.apps.create(name: 'eighty_app', body: file)
#=> true 
````

For more information on creating an 80app, see: [https://80legs.groovehq.com/knowledge_base/categories/80apps](https://80legs.groovehq.com/knowledge_base/categories/80apps).

#### Get a Specific App

````ruby
app = Leggy.apps.find(name: 'TextFromURLListOnly.js')
app.name
#=> "TextFromURLListOnly.js"
````

#### Delete an App 

*CAUTION* This action cannot be undone. 

````ruby
Leggy.apps.delete(name: 'sample_delete')
#=> true
````

### Url Lists

See [http://datafiniti.github.io/80docs/?ruby#url-lists](http://datafiniti.github.io/80docs/?ruby#url-lists) for complete documentation.

#### Upload Url List

With the list.json file as follows:

````
[
  "http://example.com",
  "https://example.org"
]
````

You can now upload the list.json url list to 80legs: 

````ruby 
file = File.read(/path/to/my/urls/list.json)
url = Leggy.urls.create(name: 'sample', body: file)
urls.name
#=> "sample"
````

#### Get All Url Lists

````ruby
urls = Leggy.urls.all
urls.collect(&:name)
#=> ["sample"]
````

#### Get Specific Url List 

Given your list.json file uploaded previously includes http://example.com && http://example.org:
    
````ruby
Leggy.urls.find(name: 'sample')
#=> ["http://example.com", "https://example.org"]
````

#### Delete a Url List 

*CAUTION* This action cannot be undone. 

````ruby
Leggy.urls.delete(name: 'sample')
#=> true
````

### Crawls

See [http://datafiniti.github.io/80docs/?ruby#crawls](http://datafiniti.github.io/80docs/?ruby#crawls) for complete documentation.

#### View All Crawls

````ruby
crawls = Leggy.crawls.all
crawls.first.status
#=> "COMPLETED"
````

Querying by status is not yet available. 

#### Create a Crawl 

````ruby
options = { 
  name: 'crawl_test',
  urllist: 'sample_crawl_list',
  app: "HeaderData.js",
  max_depth: 1,
  max_urls: 10  
}
Leggy.crawls.start(options)
#=> true
````

#### Get Crawl Status

````ruby
crawl = Leggy.crawls.status(name: 'crawl_test')
crawl.status 
#=> "QUEUED"
````

#### Cancel a Crawl 

````ruby
Leggy.crawls.cancel(name: 'crawl_test')
#=> true
````

Once cancelled, the crawl cannot be restarted. 

### Results

See [http://datafiniti.github.io/80docs/?ruby#results](http://datafiniti.github.io/80docs/?ruby#results) for complete documentation.

#### View Results for a Crawl

````ruby
results = Leggy.results.all(name: 'testing_crawl_results')
results.first
#=> "http://datafiniti-voltron-results.s3.amazonaws.com/<TOKEN>/167627_1.txt"
````

### Errors

See [http://datafiniti.github.io/80docs/?ruby#errors](http://datafiniti.github.io/80docs/?ruby#errors) for complete documentation.

Leggy raises the following errors: 

* 400 (Bad Request): `Leggy::Exception::BadRequest`
* 401 (Unauthorized): `Leggy::Exception::Unauthorized`
* 404 (Not Found): `Leggy::Exception::NotFound` 
* 422 (Unprocessable Entity): `Leggy::Exception::UnprocessableEntity`
* 523 (Service Unavailable): `Leggy::Exception::ServiceUnavailable` 
* 5xx (Server Error): `Leggy::Exception::ServerError` 

All exceptions inherit from `Leggy::Error`, so you can use that rescue from any exceptions this client library raises. This does not take into account errors external dependencies may raise, such as Faraday or http adapter errors. 

## Contributing

1. Fork it ( https://github.com/activefx/leggy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
