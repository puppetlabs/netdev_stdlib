# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:name_server) do
  it_behaves_like 'name is the namevar'
  it_behaves_like 'an ensurable type'
end
