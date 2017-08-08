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

  newproperty(:console) do
    desc "Console logging severity level [0-7] or 'unset'"

    validate do |value|
      if (value.to_s.match('^[0-7]$') || value == 'unset') then super(value)
      else fail "value #{value.inspect} is invalid, must be 0-7 or 'unset'"
      end
    end
  end

  newproperty(:monitor) do
    desc "Monitor (terminal) logging severity level [0-7] or 'unset'"

    validate do |value|
      if (value.to_s.match('^[0-7]$') || value == 'unset') then super(value)
      else fail "value #{value.inspect} is invalid, must be 0-7 or 'unset'"
      end
    end
  end

  newproperty(:source_interface) do
    desc 'Source interface to send syslog data from, e.g. "ethernet 2/1"'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:time_stamp_units) do
    desc 'The unit to log time values in'
    newvalues(:seconds, :milliseconds)
  end

  newproperty(:vrf) do
    desc 'The VRF associated with source_interface.'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
