# encoding: utf-8

require 'spec_helper'
describe 'tacacs_server_group' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:tacacs_server_group) do
      let(:catalog) { Puppet::Resource::Catalog.new }
      let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
      subject { described_class.attrclass(attribute) }

      it_behaves_like 'name is the namevar'
      it_behaves_like 'array of strings property', attribute: :servers
    end
  end
  describe 'resource-api' do
    describe 'the tacacs_server_group type' do
      it 'loads' do
        expect(Puppet::Type.type(:tacacs_server_group)).not_to be_nil
      end
    end
  end
end
