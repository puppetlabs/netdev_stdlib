# encoding: utf-8

require 'spec_helper'
describe 'network_snmp' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:network_snmp) do
      let(:catalog) { Puppet::Resource::Catalog.new }
      let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

      subject { described_class.attrclass(attribute) }

      it_behaves_like 'name is the namevar'
      it_behaves_like 'enabled type'

      %i[contact location].each do |param|
        describe param.to_s do
          let(:attribute) { param }
          include_examples '#doc Documentation'
          include_examples 'string value'
        end
      end
    end
  end
  describe 'resource-api' do
    describe 'the network_snmp type' do
      it 'loads' do
        expect(Puppet::Type.type(:network_snmp)).not_to be_nil
      end
    end
  end
end
