# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'leggy/version'

Gem::Specification.new do |spec|
  spec.name          = "leggy"
  spec.version       = Leggy::VERSION
  spec.authors       = ["Matt Solt"]
  spec.email         = ["mattsolt@gmail.com"]
  spec.summary       = %q{Ruby wrapper for the 80Legs API}
  spec.description   = %q{Ruby wrapper for the 80Legs API.}
  spec.homepage      = "https://github.com/activefx/leggy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "dotenv"

  spec.add_dependency "gem_config", "~> 0.3"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "resource_kit", "~> 0.1"
  spec.add_dependency "kartograph", "~> 0.2"
  spec.add_dependency "activesupport", ">= 4.0", "< 6"

end
