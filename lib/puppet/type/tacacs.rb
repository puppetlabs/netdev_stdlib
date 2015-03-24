# encoding: utf-8

Puppet::Type.newtype(:tacacs) do
  @doc = 'Enable or disable tacacs functionality'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'Resource name, not used to manage the device'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:enable) do
    desc 'Enable or disable tacacs functionality [true|false]'
    newvalues(:true, :false)
  end
end
