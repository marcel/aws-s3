# -*- encoding: utf-8 -*-
require File.expand_path('../lib/aws/s3/version', __FILE__)

Gem::Specification.new do |s|
  s.name              = 'aws-s3'
  s.version           = AWS::S3::Version
  s.platform          = Gem::Platform::RUBY
  s.authors           = ['Marcel Molina Jr.']
  s.email             = ['marcel@vernix.org']
  s.summary           = "Client library for Amazon's Simple Storage Service's REST API"
  s.description       = s.summary
  s.homepage          = 'http://amazon.rubyforge.org'
  s.rubyforge_project = 'amazon'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.extra_rdoc_files  = %w(README COPYING INSTALL)
  s.rdoc_options  = ['--title', "AWS::S3 -- Support for Amazon S3's REST api",
                     '--main',  'README',
                     '--line-numbers', '--inline-source']

  s.add_dependency 'xml-simple'
  s.add_dependency 'builder'
  s.add_dependency 'mime-types'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'flexmock'
end
