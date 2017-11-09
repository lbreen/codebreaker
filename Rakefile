require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Look for style guide offenses in your code'
task :rubocop do
  sh 'rubocop --format simple || true'
end

desc 'Run the program'
task :run do
  ruby 'lib/app.rb'
end

task default: [:rubocop]
