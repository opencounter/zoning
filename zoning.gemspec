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
  spec.version = Zoning::VERSION.dup

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

  runtime_dependencies.each {|lib, version| spec.add_runtime_dependency(lib, version[0], version[1]) }

  development_dependencies = {
    "bundler" => "~> 1.5",
    "rake" => "~> 10.1.1"
  }

  development_dependencies.each {|lib, version| spec.add_development_dependency(lib, version) }
end
