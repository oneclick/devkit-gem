# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dev_kit/version"

Gem::Specification.new do |spec|
  spec.name          = "rubyinstaller-devkit"
  spec.version       = DevKit::VERSION
  spec.authors       = ["Luis Lavena"]
  spec.email         = ["luislavena@gmail.com"]
  spec.summary       = %q{PoC - RubyInstaller's DevKit as gem}
  spec.description   = spec.summary
  spec.homepage      = "http://rubyinstaller.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # requirements
  spec.required_ruby_version = ">= 1.8.7"
  spec.required_rubygems_version = ">= 1.8.23"

  # dependencies
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.4.2"
end
