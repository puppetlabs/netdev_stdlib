# encoding: utf-8

require 'spec_helper'
describe 'name_server' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:name_server) do
      it_behaves_like 'name is the namevar'
      it_behaves_like 'an ensurable type'
    end
  end
  describe 'resource-api' do
    describe 'the name_server type' do
      it 'loads' do
        expect(Puppet::Type.type(:name_server)).not_to be_nil
      end
    end
  end
end
