# encoding: utf-8

Puppet::Type.newtype(:network_dns) do
  @doc = 'Configure DNS settings for network devices'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'Name, generally "settings", not used to manage the resource'

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

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end

    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end

    def should_to_s(new_value=@should)
      self.class.format_value_for_display(new_value)
    end

    def is_to_s(current_value=@is)
      self.class.format_value_for_display(current_value)
    end
  end

  newproperty(:servers, array_matching: :all) do
    desc 'Array of DNS servers to use for name resolution'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end

    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end

    def should_to_s(new_value=@should)
      self.class.format_value_for_display(new_value)
    end

    def is_to_s(current_value=@is)
      self.class.format_value_for_display(current_value)
    end
  end
end
