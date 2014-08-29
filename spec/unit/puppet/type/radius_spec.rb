# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:radius) do
  it_behaves_like 'enabled type'
  it_behaves_like 'name is the namevar'
end
