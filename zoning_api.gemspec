# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.authors = ["OpenCounter"]
  spec.description = %q{Ruby wrapper for the Zoning.io API}
  spec.homepage = 'https://github.com/opencounter/zoning'
  spec.license = "All rights reserved."
  spec.name = 'zoning'
  spec.require_paths = ['lib']
  spec.summary = "Ruby wrapper for the Zoning.io API"
  spec.version = "0.0.4"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("json_api_client", "~> 1.1", ">= 1.1.1")
  spec.add_runtime_dependency("faraday", "~> 0.8", ">= 0.8.11")

  development_dependencies = {
    "bundler"       => "~> 1.5",
    "rake"          => "~> 10.1.1",
    "rspec"         => '~> 3.1.0',
    "guard"         => "~> 2.6",
    "guard-rspec"   => "~> 4.2.8",
    "flexmock"      => "~> 1.3.1",
    "webmock"       => "~> 1.18.0",
    "pry"           => "~> 0.10.3"
  }

  development_dependencies.each {|gem, version| spec.add_development_dependency(gem, version) }
end
