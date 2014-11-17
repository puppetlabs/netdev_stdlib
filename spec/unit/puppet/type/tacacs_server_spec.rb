# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:tacacs_server) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'it has a string property', :key
  it_behaves_like 'it has a string property', :hostname
  it_behaves_like 'an ensurable type'

  describe 'key_format' do
    let(:attribute) { :key_format }
    include_examples 'numeric parameter', min: 0, max: 7
  end

  describe 'port' do
    let(:attribute) { :port }
    include_examples 'numeric parameter', min: 0, max: 65_535
  end

  describe 'timeout' do
    let(:attribute) { :timeout }
    include_examples 'numeric parameter', min: 0, max: 604_800
  end

  it_behaves_like 'boolean', attribute: :single_connection
  it_behaves_like 'it has a string property', :group
end
