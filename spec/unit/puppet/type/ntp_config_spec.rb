# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:ntp_config) do
  it_behaves_like 'name is the namevar'
  it_behaves_like 'string', attribute: :source_interface
end
