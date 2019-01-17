require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:syslog_settings) do
    @doc = 'Configure global syslog settings'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'Resource name, not used to configure the device'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
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
        if value.to_s.match('^[0-7]$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be 0-7 or 'unset'"
        end
      end
    end

    newproperty(:facility) do
      desc 'Logging facility to use'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:monitor) do
      desc "Monitor (terminal) logging severity level [0-7] or 'unset'"

      validate do |value|
        if value.to_s.match('^[0-7]$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be 0-7 or 'unset'"
        end
      end
    end

    newproperty(:source_interface, array_matching: :all) do
      desc 'Source interface to send syslog data from, e.g. "ethernet 2/1" (array of strings for multiple)'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:time_stamp_units) do
      desc 'The unit to log time values in'
      newvalues(:seconds, :milliseconds)
    end

    newproperty(:vrf, array_matching: :all) do
      desc 'The VRF associated with source_interface (array of strings for multiple).'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:logfile_severity_level) do
      desc "Logfile severity level [0-7] or 'unset'"

      validate do |value|
        if value.to_s.match('^[0-7]$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be 0-7 or 'unset'"
        end
      end
    end

    newproperty(:logfile_name) do
      desc "Logfile file name to use or 'unset'"

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:logfile_size) do
      desc "Logging file maximum size or 'unset'"

      validate do |value|
        if value.to_s.match('^\d+$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be a valid integer or 'unset'"
        end
      end
    end

    newproperty(:buffered_severity_level) do
      desc "Buffered log severity level [0-7] or 'unset'"

      validate do |value|
        if value.to_s.match('^[0-7]$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be 0-7 or 'unset'"
        end
      end
    end

    newproperty(:buffered_size) do
      desc "Logging buffer size or 'unset'"

      validate do |value|
        if value.to_s.match('^\d+$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be a valid integer or 'unset'"
        end
      end
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'syslog_settings',
    docs: 'Configure global syslog settings',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      name: {
        type:   'String',
        desc:   'Name, generally "default", not used to manage the resource',
        behaviour: :namevar
      },
      enable: {
        type:   'Optional[Boolean]',
        desc:   'Enable or disable syslog logging [true|false]'
      },
      console: {
        type:   'Optional[Variant[Integer[0,7], Integer[-1, -1], Enum["unset"]]]',
        desc:   "Console logging severity level [0-7] or 'unset'"
      },
      facility: {
        type:   'Optional[String]',
        desc:   'Logging facility to use'
      },
      monitor: {
        type:   'Optional[Variant[Integer[0,7], Integer[-1, -1], Enum["unset"]]]',
        desc:   "Monitor (terminal) logging severity level [0-7] or 'unset'"
      },
      source_interface: {
        type:    'Optional[Array[String]]',
        desc:    'Source interface to send syslog data from, e.g. "ethernet 2/1"'
      },
      time_stamp_units: {
        type:    'Optional[Enum["seconds", "milliseconds"]]',
        desc:    'The unit to log time values in [seconds|milliseconds]'
      },
      vrf: {
        type:   'Optional[Array[String]]',
        desc:   'The VRF associated with source_interface (array of strings for multiple).'
      },
      logfile_severity_level: {
        type:   'Optional[Variant[Integer[0,7], Integer[-1, -1], Enum["unset"]]]',
        desc:   "Logfile severity level [0-7] or 'unset'"
      },
      logfile_name: {
        type:   'Optional[String]',
        desc:   "Logfile file name to use or 'unset'"
      },
      logfile_size: {
        type:   'Optional[Variant[Integer, Enum["unset"]]]',
        desc:   'Logging file maximum size'
      },
      buffered_severity_level: {
        type:   'Optional[Variant[Integer[0,7], Integer[-1, -1], Enum["unset"]]]',
        desc:   "Buffered log severity level [0-7] or 'unset'"
      },
      buffered_size: {
        type:   'Optional[Variant[Integer, Enum["unset"]]]',
        desc:   'Logging buffer size'
      }
    }
  )
end
