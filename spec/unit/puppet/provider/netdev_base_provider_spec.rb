require 'spec_helper'
require 'shoulda/matchers'

require 'puppet/provider/netdev_base_provider'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end

RSpec.describe Puppet::Provider::NetdevBaseProvider do

  let(:test_provider) { instance_double('Puppet::Provider::NetdevBaseProvider', 'test_provider') }
  let(:provider_class) { instance_double('Class', 'provider class') }
  
  before(:each) do
    allow(provider_class).to receive(:new).and_return(test_provider).once
    allow(provider_class).to receive(:const_get).with('Provider', false).and_return(provider_class).once
    allow(provider_class).to receive(:const_get).with('CiscoNexus', false).and_return(provider_class).once
    stub_const('Puppet::Provider', provider_class)
    allow(Facter).to receive(:value).with('operatingsystem').and_return(os)
  end

  context 'operating system is nexus' do
    let(:os) { 'nexus' }

    it {expect(described_class.new).to delegate_method(:get).to(:device_provider) }
    it {expect(described_class.new).to delegate_method(:set).to(:device_provider) }
    it {expect(described_class.new).to delegate_method(:canonicalize).to(:device_provider) }
    
  end
  context 'operating system is not nexus' do
    let(:os) { 'linux' }

    it { expect { described_class.new }.to raise_error Puppet::ResourceError, 'the Provider resource is not supported to run on linux' }
  end
end