# encoding: utf-8

RSpec.shared_examples 'property' do
  it 'is a property' do
    expect(described_class.attrtype(attribute)).to eq(:property)
  end
end

RSpec.shared_examples 'parameter' do
  it 'is a parameter' do
    expect(described_class.attrtype(attribute)).to eq(:param)
  end
end

RSpec.shared_examples 'an ensurable type' do |opts = { name: 'emanon' }|
  describe 'ensure' do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(name: opts[:name], catalog: catalog)
    end

    let(:attribute) { :ensure }
    subject { described_class.attrclass(attribute) }

    include_examples 'property'
    include_examples '#doc Documentation'

    %w[absent present].each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    %w[true false].each do |val|
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

RSpec.shared_examples 'boolean' do |opts|
  attribute = opts[:attribute]
  raise unless attribute
  name = opts[:name] || 'emanon'

  describe attribute.to_s do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:attribute) { attribute }
    let(:type) { described_class.new(name: name, catalog: catalog) }
    subject { described_class.attrclass(attribute) }

    include_examples 'boolean value'
    include_examples '#doc Documentation'
    include_examples 'rejects values', [0, [1], { two: :three }]
  end
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

    [0, %w[Marketing Sales], { two: :three }].each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }
          .to raise_error Puppet::ResourceError, /is invalid, must be a String/
      end
    end
  end
end

RSpec.shared_examples 'the namevar is' do |namevar|
  describe "namevar of #{namevar}" do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(title: 'emanon', catalog: catalog)
    end

    let(:attribute) { namevar.intern }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'

    it 'is a parameter' do
      expect(described_class.attrtype(attribute)).to eq(:param)
    end

    ['engineering'].each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    it "sets #{namevar} based on the title" do
      expect(type[attribute]).to eq 'emanon'
    end

    [0, %w[Marketing Sales], { two: :three }].each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }
          .to raise_error Puppet::ResourceError, /is invalid, must be a String/
      end
    end
  end
end

RSpec.shared_examples 'numeric namevar' do |opts|
  describe 'name' do
    name = opts[:name] || 5
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(name: name, catalog: catalog)
    end

    let(:attribute) { :name }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'

    it 'is a parameter' do
      expect(described_class.attrtype(attribute)).to eq(:param)
    end

    min = opts[:min]
    max = opts[:max]
    [min, max].each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.to_s)
      end
    end

    [min, min.to_s, " #{min}", " #{min} ", "#{min} "].each do |val|
      it "munges #{val.inspect} to #{min}" do
        type[attribute] = val
        expect(type[attribute]).to eq(val.to_s.strip)
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
  [{ two: :three }, nil, :undef, :undefined, 'foobar'].each do |val|
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

RSpec.shared_examples 'array of strings property' do |opts|
  attribute = opts[:attribute]
  name = opts[:name] || 'emanon'
  describe attribute.to_s do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) { described_class.new(name: name, catalog: catalog) }
    let(:attribute) { attribute }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'array of strings value'
  end
end

RSpec.shared_examples 'array of strings value' do
  ['foo', 'bar', 'foo bar baz'].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq([val])
    end
  end

  [-1, 4096, 8192, { foo: 1 }, true, false, nil].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'array of strings or integers property' do |opts|
  attribute = opts[:attribute]
  name = opts[:name] || 'emanon'
  describe attribute.to_s do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) { described_class.new(name: name, catalog: catalog) }
    let(:attribute) { attribute }
    subject { described_class.attrclass(attribute) }

    include_examples '#doc Documentation'
    include_examples 'array of strings or integers value'
  end
end

RSpec.shared_examples 'array of strings or integers value' do
  ['foo', 'bar', 'foo bar baz', 9, 500].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq([val])
    end
  end

  [{ foo: 1 }, true, false, nil].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'numeric parameter' do |opts|
  min = opts[:min]
  max = opts[:max]
  [min, max].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val)
    end
  end

  [min, min.to_s, " #{min}", " #{min} ", "#{min} "].each do |val|
    it "munges #{val.inspect} to #{min}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val.to_i)
    end
  end

  it "munges [#{min}, #{max}] to #{min}" do
    type[attribute] = [min, max]
    expect(type[attribute]).to eq(min)
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

RSpec.shared_examples 'algorithm property' do
  include_examples 'property'

  %w[md5 sha1 sha256].each do |val|
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

RSpec.shared_examples 'speed property' do
  include_examples 'property'

  %w[auto 1g 10g 40g 56g 100g 100m 10m].each do |val|
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
  include_examples 'property'

  %w[auto full half].each do |val|
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

  %w[desired on off].each do |val|
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

RSpec.shared_examples 'string' do |opts|
  attribute = opts[:attribute]
  raise unless attribute
  name = opts[:name] || 'emanon'

  describe attribute.to_s do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:attribute) { attribute }
    let(:type) { described_class.new(name: name, catalog: catalog) }
    subject { described_class.attrclass(attribute) }

    include_examples 'string value'
    include_examples '#doc Documentation'
    include_examples 'rejects values', [0, [1], { two: :three }]
  end
end

RSpec.shared_examples 'string value' do
  ['Engineering'].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end
  end

  [0, [1], { two: :three }].each do |val|
    it "rejects #{val.inspect}" do
      expect { type[attribute] = val }
        .to raise_error Puppet::ResourceError, /is invalid, must be a String/
    end
  end

  [%w[Marketing Sales]].each do |val|
    it "munges #{val.inspect} to #{val.first.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val.first)
    end
  end
end

RSpec.shared_examples 'string parameter value' do
  ['Engineering'].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end
  end

  [0, [1], { two: :three }].each do |val|
    it "rejects #{val.inspect}" do
      expect { type[attribute] = val }
        .to raise_error Puppet::ResourceError, /is invalid, must be a String/
    end
  end
end

RSpec.shared_examples 'rejects values' do |values|
  [*values].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end

RSpec.shared_examples 'accepts values' do |values|
  [*values].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end

    it "munges #{val.inspect} to #{val.intern.inspect}" do
      type[attribute] = val
      expect(type[attribute]).to eq(val.intern)
    end
  end
end

RSpec.shared_examples 'accepts values without munging' do |values|
  [*values].each do |val|
    it "accepts #{val.inspect}" do
      type[attribute] = val
    end

    it "munges #{val.inspect} to #{val.inspect} (no munging)" do
      type[attribute] = val
      expect(type[attribute]).to eq(val)
    end
  end
end

RSpec.shared_examples 'it has a string property' do |attribute|
  describe attribute.to_s do
    let(:attribute) { attribute }
    include_examples '#doc Documentation'
    include_examples 'string value'
  end
end

RSpec.shared_examples 'it has a string parameter' do |attribute|
  describe attribute.to_s do
    let(:attribute) { attribute }
    include_examples '#doc Documentation'
    include_examples 'string parameter value'
  end
end

RSpec.shared_examples 'it has an array property' do |attribute|
  describe attribute.to_s do
    let(:attribute) { attribute }
    include_examples '#doc Documentation'

    ['foo'].each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    [0, { two: :three }].each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }
          .to raise_error Puppet::ResourceError, /is invalid, must be a String/
      end
    end

    [%w[one two three], %w[one], []].each do |val|
      it "accepts #{val.inspect} without munging" do
        type[attribute] = val
        expect(type[attribute]).to eq(val)
      end
    end
  end
end
