# encoding: utf-8

require 'spec_helper'

describe Puppet::Type.type(:syslog_settings) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) { described_class.new(name: 'emanon', catalog: catalog) }
  subject { described_class.attrclass(attribute) }

  it_behaves_like 'name is the namevar'
  it_behaves_like 'enabled type'

  describe 'time_stamp_units' do
    let(:attribute) { :time_stamp_units }
    include_examples '#doc Documentation'
    include_examples 'accepts values', %w(seconds milliseconds)
    include_examples 'rejects values', %w(foo bar baz)
  end
end
