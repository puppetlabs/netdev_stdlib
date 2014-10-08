# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:network_snmp) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }

  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'enabled type'

  [:contact, :location].each do |param|
    describe param.to_s do
      let(:attribute) { param }
      include_examples '#doc Documentation'
      include_examples 'string value'
    end
  end
end
