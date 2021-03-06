# encoding: utf-8

require 'spec_helper'
describe 'network_dns' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:network_dns) do
      let(:catalog) { Puppet::Resource::Catalog.new }
      let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

      subject { described_class.attrclass(attribute) }

      it_behaves_like 'the namevar is', :name
      it_behaves_like 'it has a string property', :domain
      it_behaves_like 'it has a string property', :hostname
      it_behaves_like 'it has an array property', :servers
      it_behaves_like 'it has an array property', :search
    end
  end
  describe 'resource-api' do
    describe 'the network_dns type' do
      it 'loads' do
        expect(Puppet::Type.type(:network_dns)).not_to be_nil
      end
    end
  end
end
