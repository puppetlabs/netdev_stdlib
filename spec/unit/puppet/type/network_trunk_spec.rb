# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:network_trunk) do
  it_behaves_like 'an ensurable type'
  it_behaves_like 'name is the namevar'

  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

  describe 'encapsulation' do
    let(:attribute) { :encapsulation }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'rejected parameter values'

    %w(dot1q isl negotiate none).each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end
  end

  describe 'mode' do
    let(:attribute) { :mode }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'rejected parameter values'

    %w(access trunk dynamic_auto dynamic_desirable).each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end
  end

  describe 'untagged_vlan' do
    let(:attribute) { :untagged_vlan }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'vlan id value'
  end

  describe 'tagged_vlans' do
    let(:attribute) { :tagged_vlans }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'vlan range value'
  end

  describe 'pruned_vlans' do
    let(:attribute) { :pruned_vlans }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'vlan range value'
  end
end
