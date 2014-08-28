# encoding: utf-8

Puppet::Type.newtype(:syslog_settings) do
  @doc = 'Configure global syslog settings'

  newparam(:name, namevar: true) do
    desc 'The hostname or address of the NTP server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:enable) do
    desc 'Enable or disable syslog logging [true|false]'
    newvalues(:true, :false)
  end

  newproperty(:time_stamp_units) do
    desc 'The unit to log time values in'
    newvalues(:seconds, :milliseconds)
  end
end
