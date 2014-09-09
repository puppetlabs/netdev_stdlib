# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'netdev_stdlib/version'

Gem::Specification.new do |spec|
  spec.name          = 'puppetmodule-netdev_stdlib'
  spec.version       = NetdevStdlib::VERSION
  spec.authors       = ['Jeff McCune']
  spec.email         = ['jeff@puppetlabs.com']
  spec.description   = %q{NetDev Standard Library provides Puppet types to configure network devices}
  spec.summary       = %q{Type definitions for Networking Device (NetDev) Standard Library}
  spec.homepage      = 'https://github.com/puppetlabs/netdev_stdlib'
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Development
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'pry'
  # Testing
  spec.add_development_dependency 'rspec-puppet'
  spec.add_development_dependency 'rspec', '~> 2.13.0'
  spec.add_development_dependency 'puppetlabs_spec_helper'
  spec.add_development_dependency 'simplecov'

  spec.add_dependency 'puppet'
end
