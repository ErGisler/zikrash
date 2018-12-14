# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zikrash/version'

Gem::Specification.new do |spec|
  spec.name          = 'zikrash'
  spec.version       = Zikrash::VERSION
  spec.authors       = ['Ervinas Gisleris']
  spec.email         = ['er.gisler@gmail.com']

  spec.summary       = %q{Rails Exception reporter}
  spec.description   = %q{Reports Exception data to external server}
  spec.homepage      = 'http://rubygems.org/gems/zikrash'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'railties', '>= 3.0.0'
end
