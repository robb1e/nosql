# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nosql/version'

Gem::Specification.new do |gem|
  gem.name          = "nosql"
  gem.version       = Nosql::VERSION
  gem.authors       = ["JT Archie, Robbie Clutton"]
  gem.email         = [""]
  gem.description   = %q{A simple ActiveRecord 'adapter' that raises on any call}
  gem.summary       = %q{A simple ActiveRecord 'adapter' that raises on any call}
  gem.homepage      = "http://github.com/robb1e/nosql"

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
