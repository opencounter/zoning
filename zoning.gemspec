# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoning/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_dependency 'sawyer', '~> 0.5.3'
  spec.authors = ["OpenCounter"]
  spec.description = %q{Ruby wrapper for the Zoning.io API}
  spec.email = ['joel@opencounter.us']
  spec.homepage = 'https://github.com/opencounter/zoning'
  spec.license = "All rights reserved."
  spec.name = 'zoning'
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.2'
  spec.required_rubygems_version = '>= 1.3.5'
  spec.summary = "Ruby wrapper for the Zoning.io API"
  spec.version = Zoning::VERSION.dup

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  runtime_dependencies = {
    "faraday" => "~> 0.9.0",
    "oj" => "~> 2.10.0"
  }

  runtime_dependencies.each {|lib, version| spec.add_runtime_dependency(lib, version) }

  development_dependencies = {
    "bundler" => "~> 1.5",
    "rake"    => "~> 10.1.1"
  }

  development_dependencies.each {|lib, version| spec.add_development_dependency(lib, version) }
end