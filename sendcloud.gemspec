# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendcloud/version'

Gem::Specification.new do |spec|
  spec.name          = "sendcloud"
  spec.version       = Sendcloud::VERSION
  spec.authors       = ["Jing Li"]
  spec.email         = ["lym125@gmail.com"]
  spec.description   = %q{Sendcloud library for Ruby}
  spec.summary       = %q{Idiomatic library for using the sendcloud API from within ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency(%q<rest-client>, [">= 0"])
  spec.add_dependency(%q<multimap>, [">= 0"])
  
  spec.add_development_dependency(%q<rspec>, [">= 2"])
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
