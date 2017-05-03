# encoding: utf-8

require_relative '../../puppet_x/puppetlabs/netdev_stdlib/property/port_range'

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

  newproperty(:key, parent: PuppetX::PuppetLabs::NetdevStdlib::Property::PortRange) do
    desc 'Authentication key ID'

    munge { |v| Integer(v) }
  end

  newproperty(:maxpoll) do
    desc 'The maximul poll interval'
    munge { |v| Integer(v) }
  end

  newproperty(:minpoll) do
    desc 'The minimum poll interval'
    munge { |v| Integer(v) }
  end

  newproperty(:prefer) do
    desc 'Prefer this NTP server [true|false]'
    newvalues(:true, :false)
  end

  newproperty(:source_interface) do
    desc 'The source interface used to reach the NTP server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:vrf) do
    desc 'The VRF instance this server is bound to.'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
