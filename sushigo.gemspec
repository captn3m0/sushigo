# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sushigo/version'

Gem::Specification.new do |spec|
  spec.name          = "sushigo"
  spec.version       = Sushigo::VERSION
  spec.authors       = ["Nemo"]
  spec.email         = ["me@captnemo.in"]

  spec.summary       = %q{Sushigo}
  spec.description   = %q{Sushigo}
  spec.homepage      = "https://captnemo.in/ideas/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
