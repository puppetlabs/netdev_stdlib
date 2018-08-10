# encoding: utf-8

require 'spec_helper'
describe 'syslog_facility' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:syslog_facility) do
      let(:catalog) { Puppet::Resource::Catalog.new }
      let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
      subject { described_class.attrclass(attribute) }

      it_behaves_like 'name is the namevar'
      it_behaves_like 'an ensurable type'

      describe 'level' do
        let(:attribute) { :level }
        include_examples '#doc Documentation'
        include_examples 'numeric parameter', min: 0, max: 7
      end
    end
  end
  describe 'resource-api' do
    describe 'the syslog_facility type' do
      it 'loads' do
        expect(Puppet::Type.type(:syslog_facility)).not_to be_nil
      end
    end
  end
end
