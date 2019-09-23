# encoding: utf-8

require 'spec_helper'
describe 'vrf' do
  describe 'resource-api' do
    describe 'the vrf type' do
      it 'loads' do
        expect(Puppet::Type.type(:vrf)).not_to be_nil
      end
    end
  end
end
