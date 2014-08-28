# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:syslog_server) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'an ensurable type'
  it_behaves_like 'it has a string property', :vrf
  it_behaves_like 'it has a string property', :source_interface

  describe 'severity_level' do
    let(:attribute) { :severity_level }
    include_examples '#doc Documentation'
    include_examples 'numeric parameter', min: 0, max: 7
  end
end
