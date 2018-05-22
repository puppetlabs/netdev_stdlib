# encoding: utf-8

require 'spec_helper'
describe 'syslog_settings' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:syslog_settings) do
      let(:catalog) { Puppet::Resource::Catalog.new }
      let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
      subject { described_class.attrclass(attribute) }

      it_behaves_like 'name is the namevar'
      it_behaves_like 'enabled type'
      it_behaves_like 'array of strings property', attribute: :source_interface
      it_behaves_like 'array of strings property', attribute: :vrf

      describe 'console' do
        let(:attribute) { :console }
        include_examples '#doc Documentation'
        include_examples 'accepts values without munging', %w[0 unset]
        include_examples 'rejects values', %w[foo -1 9]
      end

      describe 'monitor' do
        let(:attribute) { :monitor }
        include_examples '#doc Documentation'
        include_examples 'accepts values without munging', %w[0 unset]
        include_examples 'rejects values', %w[foo -1 9]
      end

      describe 'time_stamp_units' do
        let(:attribute) { :time_stamp_units }
        include_examples '#doc Documentation'
        include_examples 'accepts values', %w[seconds milliseconds]
        include_examples 'rejects values', %w[foo bar baz]
      end
    end
  end
  describe 'resource-api' do
    describe 'the syslog_settings type' do
      it 'loads' do
        expect(Puppet::Type.type(:syslog_settings)).not_to be_nil
      end
    end
  end
end
