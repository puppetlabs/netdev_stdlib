require 'spec_helper'

describe Puppet::Type.type(:network_vlan) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:vlan) { described_class.new(:name => "100", :catalog => catalog) }

  describe "ensure" do
    let(:attribute) { :ensure }
    subject { described_class.attrclass(attribute) }

    it "is a property" do
      expect(subject).to be < Puppet::Property::Ensure
    end

    it "has documentation" do
      expect(subject.doc).to be_a_kind_of(String)
    end
  end

  describe "vlan_name" do
    let(:attribute) { :vlan_name }
    subject { described_class.attrclass(attribute) }

    it "is a param (because id is the namevar)" do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    ["Engineering"].each do |val|
      it "accepts #{val.inspect}" do
        vlan[attribute] = val
      end
    end

    it "rejects [1]" do
      expect { vlan[:vlan_name] = [1] }.to raise_error Puppet::ResourceError
    end

    it 'rejects {two: :three}' do
      expect { vlan[:vlan_name] = {two: :three} }.to raise_error Puppet::ResourceError
    end
  end

  describe "description" do
    let(:attribute) { :description }
    subject { described_class.attrclass(attribute) }

    it "is a property" do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    ["Engineering VLAN"].each do |desc|
      it "accepts #{desc.inspect}" do
        vlan[attribute] = desc
      end
    end

    [0, [1], {:two => :three}].each do |val|
      it "rejects #{val.inspect}" do
        expect { vlan[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end

  describe "id" do
    let(:attribute) { :id }
    subject { described_class.attrclass(attribute) }

    it "is a parameter" do
      expect(described_class.attrtype(attribute)).to eq(:param)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    [100, "100"].each do |val|
      it "validates #{val.inspect} as isomorphic to '100'"  do
        vlan[attribute] = val
        expect(vlan[attribute]).to eq(val.to_s)
      end
    end

    [{:two => :three}, "abc"].each do |val|
      it "rejects #{val.inspect} as invalid" do
        expect { vlan[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end

  describe "shutdown" do
    let(:attribute) { :shutdown }
    subject { described_class.attrclass(attribute) }

    it "is a property" do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    [true, "true", :true].each do |val|
      it "munges #{val.inspect} to :true" do
        vlan[attribute] = val
        expect(vlan[attribute]).to eq(:true)
      end
    end

    [false, "false", :false].each do |val|
      it "munges #{val.inspect} to :false" do
        vlan[attribute] = val
        expect(vlan[attribute]).to eq(:false)
      end
    end

    [0, [1], {:two => :three}].each do |val|
      it "rejects #{val.inspect} as invalid" do
        expect { vlan[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end
end
