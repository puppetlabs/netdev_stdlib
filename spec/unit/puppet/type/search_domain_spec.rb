# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:search_domain) do
  it_behaves_like 'name is the namevar'
  it_behaves_like 'an ensurable type'
end
