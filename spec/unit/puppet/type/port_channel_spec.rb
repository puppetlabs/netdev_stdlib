require 'spec_helper'

describe Puppet::Type.type(:port_channel) do
  it_behaves_like 'an ensurable type'
  it_behaves_like 'name is the namevar'

  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(:name => 'emanon', :catalog => catalog) }

  subject { described_class.attrclass(attribute) }

  describe 'force' do
    let(:attribute) { :force }

    include_examples '#doc Documentation'
    include_examples 'boolean parameter'
  end

  describe 'id' do
    let(:attribute) { :id }

    include_examples '#doc Documentation'
    include_examples 'rejected parameter values'
    include_examples 'numeric parameter'
  end

  describe 'description' do
    let(:attribute) { :description }

    include_examples '#doc Documentation'
    include_examples 'description property'
  end

  describe 'mode' do
    let(:attribute) { :mode }

    include_examples '#doc Documentation'
    include_examples 'rejected parameter values'

    %w{active passive disabled}.each do |val|
      it "munges #{val.inspect} to #{val.intern.inspect}" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.intern)
      end
    end
  end

  describe 'minimum_links' do
    let(:attribute) { :minimum_links }

    include_examples '#doc Documentation'
    include_examples 'rejected parameter values'
    include_examples 'numeric parameter'
  end

  describe 'interfaces' do
    let(:attribute) { :interfaces }

    include_examples '#doc Documentation'
    include_examples 'interface list value'
  end

  describe 'speed' do
    let(:attribute) { :speed }

    include_examples '#doc Documentation'
    include_examples 'speed property'
  end

  describe 'duplex' do
    let(:attribute) { :duplex }

    include_examples '#doc Documentation'
    include_examples 'duplex property'
  end

  describe 'flowcontrol_send' do
    let(:attribute) { :flowcontrol_send }

    include_examples '#doc Documentation'
    include_examples 'flowcontrol property'
  end

  describe 'flowcontrol_receive' do
    let(:attribute) { :flowcontrol_receive }

    include_examples '#doc Documentation'
    include_examples 'flowcontrol property'
  end
end
