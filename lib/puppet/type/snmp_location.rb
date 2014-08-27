# encoding: utf-8

Puppet::Type.newtype(:snmp_location) do
  @doc = 'Set the SNMP location string'

  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the device location'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
