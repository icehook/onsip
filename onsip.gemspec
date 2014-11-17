# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onsip/version'

Gem::Specification.new do |spec|
  spec.name          = "onsip"
  spec.version       = OnSIP::VERSION
  spec.authors       = ["Keith Larrimore"]
  spec.email         = ["klarrimore@icehook.com"]
  spec.summary       = %q{Onsip Ruby client.}
  spec.description   = %q{Onsip Ruby client.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'ffaker', '~> 1.15.0'
  spec.add_development_dependency 'machinist', '~> 2.0'
  spec.add_development_dependency 'webmock', '~> 1.17.4'
  spec.add_development_dependency 'guard-rspec', '~> 4.2.8'
  spec.add_development_dependency 'rb-fsevent', '~> 0.9.3'
  spec.add_development_dependency 'simplecov', '~> 0.8.2'
  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'trollop', '~> 2.0'
  spec.add_runtime_dependency 'multi_json', '~> 1.10.1'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.1'
  spec.add_runtime_dependency 'faraday', '~> 0.9.0'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9.1'
  spec.add_runtime_dependency 'awesome_print', '~> 1.2.0'
  spec.add_runtime_dependency 'builder', '~> 3.2.2'
  spec.add_runtime_dependency 'hashie', '~> 3.3.1'
end
