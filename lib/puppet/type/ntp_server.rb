require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  require_relative '../../puppet_x/puppetlabs/netdev_stdlib/property/port_range'

  Puppet::Type.newtype(:ntp_server) do
    @doc = 'Specify an NTP server'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'The hostname or address of the NTP server'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
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
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:vrf) do
      desc 'The VRF instance this server is bound to.'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'ntp_server',
    docs: 'Specify an NTP server',
    features: ['remote_resource'],
    attributes: {
      ensure:       {
        type:       'Enum[present, absent]',
        desc:       'Whether this NTP server should be present or absent on the target system.',
        default:    'present'
      },
      name:         {
        type:      'String',
        desc:      'The hostname or address of the NTP server',
        behaviour: :namevar
      },
      key:          {
        type:      'Optional[Integer[1, 65535]]',
        desc:      'Authentication key ID'
      },
      maxpoll:      {
        type:      'Optional[Integer]',
        desc:      'The maximum poll interval'
      },
      minpoll:      {
        type:      'Optional[Integer]',
        desc:      'The minimum poll interval'
      },
      prefer:       {
        type:      'Optional[Boolean]',
        desc:      'Prefer this NTP server [true|false]',
        default:   false
      },
      source_interface:     {
        type:      'Optional[String]',
        desc:      'The source interface used to reach the NTP server'
      },
      vrf:          {
        type:      'Optional[String]',
        desc:      'The VRF instance this server is bound to.'
      }
    }
  )
end
