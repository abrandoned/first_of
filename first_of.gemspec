# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'first_of/version'

Gem::Specification.new do |spec|
  spec.name          = "first_of"
  spec.version       = FirstOf::VERSION
  spec.authors       = ["Brandon Dewitt"]
  spec.email         = ["brandonsdewitt@gmail.com"]
  spec.description   = %q{ prioritize values of fallback methods }
  spec.summary       = %q{ first_of allows you to setup a method that falls back to the next prioritized value
                           if the first and subsequent return objects are not present.  To be used in situations
                           where multiple values are "valid" but have a priority of when to use each value }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "try_chain"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
