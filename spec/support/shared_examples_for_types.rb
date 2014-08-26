RSpec.shared_examples 'an ensurable type' do
  describe 'ensure' do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(:name => 'emanon', :catalog => catalog)
    end

    let(:attribute) { :ensure }
    subject { described_class.attrclass(attribute) }

    it 'is a property' do
      expect(described_class.attrtype(:ensure)).to eq(:property)
    end

    it 'has documentation' do
      expect(subject.doc).to be_a_kind_of(String)
    end

    %w{absent present}.each do |val|
      it "accepts #{val.inspect}" do
        type[attribute] = val
      end
    end

    %w{true false}.each do |val|
      it "rejects #{val.inspect}" do
        expect { type[attribute] = val }.to raise_error Puppet::ResourceError
      end
    end
  end
end

RSpec.shared_examples 'name is the namevar' do
  describe 'name' do
    let(:catalog) { Puppet::Resource::Catalog.new }
    let(:type) do
      described_class.new(:name => 'emanon', :catalog => catalog)
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

    [0, ['Marketing', 'Sales'], {:two => :three}].each do |val|
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

  it '#doc is not empty' do
    expect(subject.doc).not_to be_empty
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

  it 'munges [10,20] to 10' do
    type[attribute] = [10,20]
    expect(type[attribute]).to eq(10)
  end

  [-1, 4096, 8192, "asdf", {foo: 1}, true, false, nil].each do |val|
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

  it 'munges [10,20] to [10,20]' do
    type[attribute] = [10,20]
    expect(type[attribute]).to eq([10,20])
  end

  [-1, 4096, 8192, "asdf", {foo: 1}, true, false, nil].each do |val|
    it "rejects #{val.inspect} with a Puppet::Error" do
      expect { type[attribute] = val }.to raise_error Puppet::Error
    end
  end
end
