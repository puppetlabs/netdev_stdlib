# encoding: utf-8

require 'spec_helper'
describe 'domain_name' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:domain_name) do
      it_behaves_like 'name is the namevar'
      it_behaves_like 'an ensurable type'
    end
  end
  describe 'resource-api' do
    describe 'the domain_name type' do
      it 'loads' do
        expect(Puppet::Type.type(:domain_name)).not_to be_nil
      end
    end
  end
end
