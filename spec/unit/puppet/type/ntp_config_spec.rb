# encoding: utf-8

require 'spec_helper'
describe 'ntp_config' do
  describe 'old style' do
    fake_operatingsystem
    describe Puppet::Type.type(:ntp_config) do
      it_behaves_like 'name is the namevar'
      it_behaves_like 'string', attribute: :source_interface
      it_behaves_like 'boolean', attribute: :authenticate
      it_behaves_like 'array of strings or integers property', attribute: :trusted_key
    end
  end
  describe 'resource-api' do
    describe 'the ntp_config type' do
      it 'loads' do
        expect(Puppet::Type.type(:ntp_config)).not_to be_nil
      end
    end
  end
end
