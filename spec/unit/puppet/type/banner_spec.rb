# encoding: utf-8

require 'spec_helper'
describe 'banner' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:banner) do
      it_behaves_like 'name is the namevar'
    end
  end
  describe 'resource-api' do
    describe 'the banner type' do
      it 'loads' do
        expect(Puppet::Type.type(:banner)).not_to be_nil
      end
    end
  end
end
