# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gdirections/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Patrick Sharp"]
  gem.email         = ["jakanapes@gmail.com"]
  gem.description   = %q{Wrapper for Google's Direction API}
  gem.summary       = %q{Find directions between two map locations}
  gem.homepage      = "https://github.com/Jakanapes/gdirections"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gdirections"
  gem.require_paths = ["lib"]
  gem.version       = Gdirections::VERSION
  
  gem.add_dependency 'json'
  gem.add_development_dependency "rspec", ">= 2.0.0"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "rake"
end
