# encoding: utf-8

Puppet::Type.newtype(:ntp_config) do
  @doc = 'Global configuration for the NTP system'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'Resource name, not used to configure the device'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:source_interface) do
    desc 'The source interface for the NTP system'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
