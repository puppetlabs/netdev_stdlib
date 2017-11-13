# encoding: utf-8

require_relative '../../puppet_x/puppetlabs/netdev_stdlib/property/port_range'

Puppet::Type.newtype(:syslog_server) do
  @doc = 'Configure a remote syslog server for logging'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The hostname or address of the remote syslog server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:port, parent: PuppetX::PuppetLabs::NetdevStdlib::Property::PortRange) do
    desc 'Port number of remote syslog server'

    munge { |v| Integer(v) }
  end

  newproperty(:severity_level) do
    desc 'Syslog severity level to log'
    munge { |v| Integer(v) }
  end

  newproperty(:vrf) do
    desc 'Interface to send syslog data from, e.g. "management"'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
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
end
