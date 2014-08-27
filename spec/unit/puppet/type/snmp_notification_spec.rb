# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:snmp_notification) do
  it_behaves_like 'name is the namevar'
  it_behaves_like 'enabled type'
end
