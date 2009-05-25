require 'rake'
require 'rake/testtask'

task :default => ['test:units']

namespace :test do
  desc "Run tests"
  puts Time.now.utc.strftime("%Y-%m-%d %H:%M:%S UTC")
  Rake::TestTask.new("units") do |t|
    t.pattern='test/test_*.rb'
    t.verbose = true
    t.warning = true
  end
end