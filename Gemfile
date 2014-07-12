source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

group :development do
  gem 'guard'
  gem 'guard-rspec', :require => false
end

group :development, :test do
  gem 'rake', '~> 10.1.0',       :require => false
  gem 'rspec-puppet',            :require => false
  gem 'rspec', '~> 2.13.0'
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'pry',                     :require => false
  gem 'simplecov',               :require => false
end

ENV['GEM_PUPPET_VERSION'] ||= ENV['PUPPET_GEM_VERSION']
puppetversion = ENV['GEM_PUPPET_VERSION']
if puppetversion
  gem 'puppet', *location_for(puppetversion)
else
  gem 'puppet', :require => false
end

if File.exists? "#{__FILE__}.local"
  eval(File.read("#{__FILE__}.local"), binding)
end
# vim:ft=ruby
