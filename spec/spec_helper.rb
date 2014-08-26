# encoding: utf-8

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'
end

dir = File.expand_path(File.dirname(__FILE__))

require 'puppet'
require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

Dir["#{dir}/support/**/*.rb"].sort.each { |f| require f }
