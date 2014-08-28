# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:snmp_user) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

  subject { described_class.attrclass(attribute) }

  it_behaves_like 'an ensurable type'
  it_behaves_like 'name is the namevar'

  describe 'roles' do
    let(:attribute) { :roles }
    include_examples '#doc Documentation'
    include_examples 'array of strings value'
  end

  describe 'auth' do
    let(:attribute) { :auth }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(md5 sha)
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'password' do
    let(:attribute) { :password }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'privacy' do
    let(:attribute) { :privacy }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(aes128 des)
    include_examples 'rejects values', %w(foo bar baz)
  end

  describe 'private_key' do
    let(:attribute) { :private_key }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'localized_key' do
    let(:attribute) { :localized_key }
    include_examples '#doc Documentation'
    include_examples 'boolean value'
  end

  describe 'enforce_privacy' do
    let(:attribute) { :enforce_privacy }
    include_examples '#doc Documentation'
    include_examples 'boolean value'
  end

  describe 'engine_id' do
    let(:attribute) { :engine_id }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end
end
