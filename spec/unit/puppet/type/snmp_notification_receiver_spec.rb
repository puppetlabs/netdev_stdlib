# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:snmp_notification_receiver) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

  subject { described_class.attrclass(attribute) }

  it_behaves_like 'an ensurable type'
  it_behaves_like 'name is the namevar'

  describe 'type' do
    let(:attribute) { :type }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(traps informs)
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'version' do
    let(:attribute) { :version }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(v1 v2 v3)
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'username' do
    let(:attribute) { :username }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'security' do
    let(:attribute) { :security }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(auth noauth priv)
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'port' do
    let(:attribute) { :port }
    include_examples '#doc Documentation'
    include_examples 'numeric parameter', 0, 65_536
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'community' do
    let(:attribute) { :community }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'vrf' do
    let(:attribute) { :vrf }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'source_interface' do
    let(:attribute) { :vrf }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end
end
