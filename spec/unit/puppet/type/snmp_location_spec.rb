# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:snmp_location) do
  it_behaves_like 'an ensurable type'
  it_behaves_like 'name is the namevar'
end
