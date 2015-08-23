# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xapix_client/version'
require "xapix_client/config"
require 'xapix_client/connection'
require 'xapix_client/resource'

Gem::Specification.new do |spec|
  spec.name          = "xapix_client"
  spec.version       = XapixClient::VERSION
  spec.authors       = ["Oliver Thamm"]
  spec.email         = ["oliver@xapix.io"]
  spec.summary       = %q{Client to the xapix.io API}
  spec.description   = %q{Access xapix.io hosted projects with the ActiveResource based json_api_client library.}
  spec.homepage      = "http://www.xapix.io"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'json_api_client', '>= 1.0.0.beta6'
end
