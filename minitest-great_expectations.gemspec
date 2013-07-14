# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/great_expectations/version'

Gem::Specification.new do |gem|
  gem.name          = "minitest-great_expectations"
  gem.version       = Minitest::GreatExpectations::VERSION
  gem.authors       = ["Matthew McEachen"]
  gem.email         = ["matthew+github@mceachen.org"]
  gem.description   = %q{Adds several generally-useful matchers and expectations to minitest and minitest/spec}
  gem.summary       = gem.description
  gem.homepage      = ""
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = %w(lib)

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'minitest'
end
