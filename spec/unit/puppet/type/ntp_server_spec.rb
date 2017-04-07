# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:ntp_server) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'boolean', attribute: :prefer
  it_behaves_like 'string', attribute: :source_interface
  it_behaves_like 'string', attribute: :vrf

  describe 'key' do
    let(:attribute) { :key }
    include_examples 'numeric parameter', min: 1, max: 65_535
  end

  describe 'maxpoll' do
    let(:attribute) { :maxpoll }
    include_examples 'numeric parameter', min: 0, max: 65_535
  end

  describe 'minpoll' do
    let(:attribute) { :minpoll }
    include_examples 'numeric parameter', min: 0, max: 65_535
  end
end
