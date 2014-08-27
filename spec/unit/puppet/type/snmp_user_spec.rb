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

    %w(md5 sha).each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end

      it "munges #{val.inspect} to #{val.intern.inspect}" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.intern)
      end
    end

    it 'rejects "foo" with a Puppet::Error' do
      expect { type[attribute] = 'foo' }.to raise_error Puppet::Error
    end
  end

  describe 'password' do
    let(:attribute) { :password }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end

  describe 'privacy' do
    let(:attribute) { :privacy }
    include_examples '#doc Documentation'

    %w(aes128 des).each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end

      it "munges #{val.inspect} to #{val.intern.inspect}" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.intern)
      end
    end

    it 'rejects "foo" with a Puppet::Error' do
      expect { type[attribute] = 'foo' }.to raise_error Puppet::Error
    end
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
