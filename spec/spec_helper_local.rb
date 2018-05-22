# automatically load any shared examples or contexts
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

require 'simplecov'
require 'shared_functions'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'
end
