# encoding: utf-8
Puppet::Type.newtype(:tacacs_server_group) do
  @doc = 'Configure a tacacs server group'

  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the tacacs server group'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:servers, array_matching: :all) do
    desc 'Array of servers associated with this group'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
