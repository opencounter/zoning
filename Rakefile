require "bundler/gem_tasks"

begin
  gem 'rspec', '~> 3.1.0'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new
rescue LoadError => e
  task :spec do
    abort "Please run `gem install rspec` to install RSpec."
  end
end
task :test => :spec
task :default => :spec
