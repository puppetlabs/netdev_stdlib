# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:ntp_config) do
  it_behaves_like 'name is the namevar'
  it_behaves_like 'string', attribute: :source_interface
  it_behaves_like 'boolean', attribute: :authenticate
  it_behaves_like 'array of strings or integers property', attribute: :trusted_key
end
