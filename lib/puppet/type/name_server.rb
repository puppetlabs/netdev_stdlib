# encoding: utf-8

Puppet::Type.newtype(:name_server) do
  @doc = 'Configure the resolver to use the specified DNS server'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The hostname or address of the DNS server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
