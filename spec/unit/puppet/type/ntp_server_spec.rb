# encoding: utf-8

require 'spec_helper'
describe 'ntp_server' do
  describe 'old style' do
    fake_operatingsystem
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
  end
  describe 'resource-api' do
    describe 'the ntp_server type' do
      it 'loads' do
        expect(Puppet::Type.type(:ntp_server)).not_to be_nil
      end
    end
  end
end
