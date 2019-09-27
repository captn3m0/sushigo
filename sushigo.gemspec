# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sushigo/version'

Gem::Specification.new do |spec|
  spec.name          = 'sushigo'
  spec.version       = Sushigo::VERSION
  spec.authors       = ['Nemo']
  spec.email         = ['me@captnemo.in']

  spec.summary       = 'Sushigo'
  spec.description   = 'Sushigo'
  spec.homepage      = 'https://github.com/captn3m0/sushigo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
