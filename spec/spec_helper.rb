# encoding: utf-8

dir = File.expand_path(File.dirname(__FILE__))

require 'puppet'
require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

Dir["#{dir}/support/**/*.rb"].sort.each { |f| require f }
