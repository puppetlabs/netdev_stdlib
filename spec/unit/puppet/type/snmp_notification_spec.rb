# encoding: utf-8

require 'spec_helper'
describe 'snmp_notification' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:snmp_notification) do
      it_behaves_like 'name is the namevar'
      it_behaves_like 'enabled type'
    end
  end
  describe 'resource-api' do
    describe 'the snmp_notification type' do
      it 'loads' do
        expect(Puppet::Type.type(:snmp_notification)).not_to be_nil
      end
    end
  end
end
