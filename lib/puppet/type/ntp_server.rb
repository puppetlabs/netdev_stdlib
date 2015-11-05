# encoding: utf-8

Puppet::Type.newtype(:ntp_server) do
  @doc = 'Specify an NTP server'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The hostname or address of the NTP server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:prefer) do
    desc 'Prefer this NTP server [true|false]'
    newvalues(:true, :false)
  end
end
