require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec

Rake.add_rakelib("tasks")
