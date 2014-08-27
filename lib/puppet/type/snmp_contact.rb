# encoding: utf-8

Puppet::Type.newtype(:snmp_contact) do
  @doc = 'Set the SNMP contact name'

  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the SNMP contact'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
