# encoding: utf-8

require 'spec_helper'
describe 'tacacs' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:tacacs) do
      it_behaves_like 'enabled type'
      it_behaves_like 'name is the namevar'
    end
  end
  describe 'resource-api' do
    describe 'the tacacs type' do
      it 'loads' do
        expect(Puppet::Type.type(:tacacs)).not_to be_nil
      end
    end
  end
end
