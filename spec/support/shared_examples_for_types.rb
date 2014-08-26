# encoding: utf-8

RSpec.shared_examples 'an ensurable type' do
  describe 'ensure' do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(name: 'emanon', catalog: catalog)
    end

    let(:attribute) { :ensure }
    subject { described_class.attrclass(attribute) }

    it 'is a property' do
      expect(described_class.attrtype(:ensure)).to eq(:property)
    end

    it 'has documentation' do
      expect(subject.doc).to be_a_kind_of(String)
    end

    %w(absent present).each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    %w(true false).each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end
end

RSpec.shared_examples 'boolean parameter' do
  it 'is a parameter' do
    expect(described_class.attrtype(attribute)).to eq(:param)
  end

  include_examples 'boolean value'
end

RSpec.shared_examples 'boolean value' do
  [true, false, 'true', 'false', :true, :false].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end

    it "munges #{val.inspect} to #{val.to_s.intern.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val.to_s.intern)
    end
  end

  [1, -1, { foo: 1 }, [1], 'baz', nil].each do |val|
    it "rejects #{val.inspect} with Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'name is the namevar' do
  describe 'name' do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(name: 'emanon', catalog: catalog)
    end

    let(:attribute) { :name }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'

    it 'is a parameter' do
      expect(described_class.attrtype(:name)).to eq(:param)
    end

    ['Engineering'].each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    [0, %w(Marketing Sales), { two: :three }].each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }
          .to raise_error Puppet::ResourceError, /is invalid, must be a String/
      end
    end
  end
end

RSpec.shared_examples '#doc Documentation' do
  it '#doc is a String' do
    expect(subject.doc).to be_a_kind_of(String)
  end

  it '#doc is not only whitespace' do
    expect(subject.doc.gsub(/\s+/, '')).not_to be_empty
  end
end

RSpec.shared_examples 'rejected parameter values' do
  [nil, :undef, :undefined, 'foobar'].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'vlan id value' do
  [1, 10, 100, 4095].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end
  end

  it 'munges [10, 20] to 10' do
    type[attribute] = [10, 20]
    expect(type[attribute]).to eq(10)
  end

  [-1, 4096, 8192, 'asdf', { foo: 1 }, true, false, nil].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'vlan range value' do
  [1, 10, 100, 4095].each do |val|
    it "munges #{val.inspect} to [#{val}]" do
      type[attribute] = val
      expect(type[attribute]).to eq([val])
    end
  end

  it 'munges [10, 20] to [10, 20]' do
    type[attribute] = [10, 20]
    expect(type[attribute]).to eq([10, 20])
  end

  [-1, 4096, 8192, 'asdf', { foo: 1 }, true, false, nil].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'interface list value' do
  ['Ethernet1', 'Ethernet2', 'ethernet 4/2'].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq([val])
    end
  end

  [-1, 4096, 8192, 'asdf', { foo: 1 }, true, false, nil].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'numeric parameter' do
  [1, 2, 3, 4095].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val)
    end
  end

  it 'munges [1, 2] to 1' do
    type[attribute] = [1, 2]
    expect(type[attribute]).to eq(1)
  end

  it 'munges "1" to 1' do
    type[attribute] = '1'
    expect(type[attribute]).to eq(1)
  end
end

RSpec.shared_examples 'description property' do
  it 'is a property' do
    expect(described_class.attrtype(attribute)).to eq(:property)
  end

  ['Engineering VLAN'].each do |desc|
    it "accepts #{desc.inspect}" do
      type[attribute] = desc
    end
  end

  [0, [1], { two: :three }].each do |val|
    it "rejects #{val.inspect}" do
      expect { type[attribute] = val }.to raise_error Puppet::ResourceError
    end
  end
end

RSpec.shared_examples 'speed property' do
  it 'is a property' do
    expect(described_class.attrtype(attribute)).to eq(:property)
  end

  %w(auto 1g 10g 40g 56g 100g 100m 10m).each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end
  end

  [0, 15, '0', '15', { two: :three }, 'abc'].each do |val|
    it "rejects #{val.inspect} with Puppet::ResourceError" do
      expect { type[attribute] = val }.to raise_error Puppet::ResourceError
    end
  end
end

RSpec.shared_examples 'duplex property' do
  it 'is a property' do
    expect(described_class.attrtype(attribute)).to eq(:property)
  end

  %w(auto full half).each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end
  end

  [0, 15, '0', '15', { two: :three }, 'abc'].each do |val|
    it "rejects #{val.inspect} with Puppet::ResourceError" do
      expect { type[attribute] = val }.to raise_error Puppet::ResourceError
    end
  end
end

RSpec.shared_examples 'flowcontrol property' do
  it 'is a property' do
    expect(described_class.attrtype(attribute)).to eq(:property)
  end

  %w(desired on off).each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end

    it "munges #{val.inspect} to #{val.intern.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val.intern)
    end
  end

  [0, 15, '0', '15', { two: :three }, 'abc'].each do |val|
    it "rejects #{val.inspect} with Puppet::ResourceError" do
      expect { type[attribute] = val }.to raise_error Puppet::ResourceError
    end
  end
end

RSpec.shared_examples 'enabled type' do
  describe 'enable' do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(name: 'emanon', catalog: catalog)
    end

    let(:attribute) { :enable }
    subject { described_class.attrclass(attribute) }

    it 'is a property' do
      expect(described_class.attrtype(attribute)).to eq(:property)
    end

    include_examples '#doc Documentation'
    include_examples 'boolean value'
  end
end
