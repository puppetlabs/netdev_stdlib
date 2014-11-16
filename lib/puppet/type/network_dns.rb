# encoding: utf-8

Puppet::Type.newtype(:network_dns) do
  @doc = 'Configure DNS settings for network devices'

  ensurable

  newparam(:name, namevar: true) do
    desc 'Resource name, not used to configure the device'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:domain) do
    desc 'The default domain name to append to the device hostname'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:search, array_matching: :all) do
    desc 'Array of DNS suffixes to search for FQDN entries'

    validate do |val|
      fail "value #{val.inspect} must be a string" unless val.is_a? String
    end

    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end
  end

  newproperty(:servers, array_matching: :all) do
    desc 'Array of DNS servers to use for name resolution'

    validate do |val|
      fail "value #{val.inspect} must be a string" unless val.is_a? String
    end

    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end
  end

end
