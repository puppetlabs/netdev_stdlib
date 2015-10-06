# encoding: utf-8

Puppet::Type.newtype(:syslog_settings) do
  @doc = 'Configure global syslog settings'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'Resource name, not used to configure the device'

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
