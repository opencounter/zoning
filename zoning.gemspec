# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoning/version'

Gem::Specification.new do |spec|
  spec.authors = ["OpenCounter"]
  spec.description = %q{Ruby wrapper for the Zoning.io API}
  spec.homepage = 'https://github.com/opencounter/zoning'
  spec.license = "All rights reserved."
  spec.name = 'zoning'
  spec.require_paths = ['lib']
  spec.summary = "Ruby wrapper for the Zoning.io API"
  spec.version = ZoningAPI::VERSION.dup

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  runtime_dependencies = {

    "faraday"            => ["~> 0.8", ">= 0.8.7"],
    "oj"                 => ["~> 2.3", ">= 2.3.0"],
    "oauth2"             => ["~> 1.0", ">= 1.0.0"],
    "faraday_middleware" => ["~> 0.9", ">= 0.9.1"]
  }

  runtime_dependencies.each {|gem, version| spec.add_runtime_dependency(gem, version[0], version[1]) }

  development_dependencies = {
    "bundler"       => "~> 1.5",
    "rake"          => "~> 10.1.1",
    "rspec"         => '~> 3.1.0',
    "guard"         => "~> 2.6",
    "guard-rspec"   => "~> 4.2.8",
    "flexmock"      => "~> 1.3.1",
    "webmock"       => "~> 1.18.0"
    }

  development_dependencies.each {|gem, version| spec.add_development_dependency(gem, version) }
end
