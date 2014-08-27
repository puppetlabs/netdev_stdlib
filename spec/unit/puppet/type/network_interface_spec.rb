# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:network_interface) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) do
    described_class.new(name: 'Ethernet1', catalog: catalog)
  end

  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'enabled type'

  describe 'description' do
    let(:attribute) { :description }

    include_examples 'description property'
  end

  describe 'mtu (e.g. 1500 | 9000)' do
    let(:attribute) { :mtu }

    it 'is a property' do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it 'has documentation' do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(/\s+/, '')).not_to be_empty
    end

    [100, '100', ' 100', ' 100 ', '100 ', '0'].each do |val|
      it "munges #{val.inspect} to 100" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.to_i)
      end
    end

    it 'munges [1] to 1' do
      type[attribute] = [1]
      expect(type[attribute]).to eq(1)
    end

    it 'munges [1, 2] to 1' do
      type[attribute] = [1, 2]
      expect(type[attribute]).to eq(1)
    end

    [{ two: :three }, 'abc'].each do |val|
      it "rejects #{val.inspect} as invalid" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end

  describe 'speed (auto*|10m|100m|1g|10g|40g|56g|100g)' do
    let(:attribute) { :speed }

    include_examples '#doc Documentation'
    include_examples 'speed property'
  end

  describe 'duplex (auto | full | half)' do
    let(:attribute) { :duplex }

    include_examples '#doc Documentation'
    include_examples 'duplex property'
  end
end
