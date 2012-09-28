# -*- encoding: utf-8 -*-
require File.expand_path('../lib/css_convertor/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nour"]
  gem.email         = ["nour.fwh@gmail.com"]
  gem.description   = %q{css_convertor flips the layout of your CSS file. You can use it if you're designing a website that supports both LTR and RTL languages: css_convertor will create a seperate CSS file of the new layout.}
  gem.summary       = %q{CSS LTR-RTL layout converter}
  gem.homepage      = "http://rubygems.org/gems/css_convertor"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "css_convertor"
  gem.require_paths = ["lib"]
  gem.version       = CssConvertor::VERSION
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'test-unit'
end