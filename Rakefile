require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end

task :default => :test

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "AWS::S3 -- Support for Amazon S3's REST api"
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('COPYING')
  rdoc.rdoc_files.include('INSTALL')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
