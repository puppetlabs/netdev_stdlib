# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:snmp_notification_receiver) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

  subject { described_class.attrclass(attribute) }

  it_behaves_like 'an ensurable type'
  it_behaves_like 'name is the namevar'
  it_behaves_like 'it has a string parameter', :username
  it_behaves_like 'it has a string property', :vrf
  it_behaves_like 'it has a string property', :source_interface

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

  describe 'security' do
    let(:attribute) { :security }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(auth noauth priv)
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'port' do
    let(:attribute) { :port }
    include_examples '#doc Documentation'
    include_examples 'numeric parameter', min: 0, max: 65_536
    include_examples 'rejects values', %w(foo bar baz)
  end
end
