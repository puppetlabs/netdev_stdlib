# encoding: utf-8

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_for(place, fake_version = nil)
  md1 = /^(git[:@][^#]*)#(.*)/.match(place)
  md2 = %r{^file://(.*)}.match(place)
  if md1
    [fake_version, { git: md1[1], branch: md1[2], require: false }].compact
  elsif md2
    ['>= 0', { path: File.expand_path(md2[1]), require: false }]
  else
    [place, { require: false }]
  end
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'pry-doc'
end

group :development, :test do
  gem 'rake', '~> 10.1.0',       require: false
  gem 'rspec-puppet',            require: false
  gem 'rspec', '~> 2.13.0'
  gem 'puppetlabs_spec_helper',  require: false
  gem 'pry',                     require: false
  gem 'simplecov',               require: false
end

ENV['GEM_PUPPET_VERSION'] ||= ENV['PUPPET_GEM_VERSION']
puppetversion = ENV['GEM_PUPPET_VERSION']
if puppetversion
  gem 'puppet', *location_for(puppetversion)
else
  gem 'puppet', require: false
end

# vim:ft=ruby
