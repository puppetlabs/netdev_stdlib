require 'spec_helper'

describe Puppet::Type.type(:network_interface) do
  let(:catalog) { Puppet::Resource::Catalog.new }
  let(:type) do
    described_class.new(:name => "Ethernet1", :catalog => catalog)
  end

  describe 'enable' do
    let(:attribute) { :enable }
    subject { described_class.attrclass(attribute) }

    it 'is a property' do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      expect(subject.doc).to be_a_kind_of(String)
    end

    %w{true false}.each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end
  end

  describe "name" do
    let(:attribute) { :name }
    subject { described_class.attrclass(attribute) }

    it "is a param" do
      expect(described_class.attrtype(attribute)).to eq(:param)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    ["Engineering"].each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    [0, [1], {:two => :three}].each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
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
        type[attribute] = desc
      end
    end

    [0, [1], {:two => :three}].each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end

  describe "mtu (e.g. 1500 | 9000)" do
    let(:attribute) { :mtu }
    subject { described_class.attrclass(attribute) }

    it "is a property" do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    [100, "100", " 100", " 100 ", "100 ", "0"].each do |val|
      it "munges #{val.inspect} to 100" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.to_i)
      end
    end

    it "munges [1] to 1" do
      type[attribute] = [1]
      expect(type[attribute]).to eq(1)
    end

    it "munges [1,2] to 1" do
      type[attribute] = [1,2]
      expect(type[attribute]).to eq(1)
    end

    [{:two => :three}, "abc"].each do |val|
      it "rejects #{val.inspect} as invalid" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end

  describe "speed (auto*|10m|100m|1g|10g|40g|56g|100g)" do
    let(:attribute) { :speed }
    subject { described_class.attrclass(attribute) }

    it "is a property" do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    %w{auto 1g 10g 40g 56g 100g 100m 10m}.each do |val|
      it "accepts #{val}" do
        type[attribute] = val
      end
    end

    [0, 15, "0", "15", {:two => :three}, "abc"].each do |val|
      it "rejects #{val.inspect} as invalid" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end

  describe "duplex (auto | full | half)" do
    let(:attribute) { :duplex }
    subject { described_class.attrclass(attribute) }

    it "is a property" do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    it "has documentation" do
      # Remove all whitespace to see if there's actually content
      expect(subject.doc.gsub(%r{\s+}, '')).not_to be_empty
    end

    %w{auto full half}.each do |val|
      it "accepts #{val}" do
        type[attribute] = val
      end
    end

    [0, 15, "0", "15", {:two => :three}, "abc"].each do |val|
      it "rejects #{val.inspect} as invalid" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end
end
