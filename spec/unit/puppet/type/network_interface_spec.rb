# encoding: utf-8

require 'spec_helper'
describe 'network_interface' do
  describe 'old style' do
    fake_operatingsystem
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

        include_examples 'property'
        include_examples '#doc Documentation'
        include_examples 'numeric parameter', min: 1, max: 65_536
        include_examples 'rejected parameter values'
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
    describe 'resource-api' do
      describe 'the network_interface type' do
        it 'loads' do
          expect(Puppet::Type.type(:network_interface)).not_to be_nil
        end
      end
    end
  end
end
