# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:snmp_community) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'an ensurable type'

  describe 'group' do
    let(:attribute) { :group }
    include_examples 'property'
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'acl' do
    let(:attribute) { :acl }
    include_examples '#doc Documentation'
    include_examples 'property'
    include_examples 'string value'
  end
end
