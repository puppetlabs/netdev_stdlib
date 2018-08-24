require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type

  Puppet::Type.newtype(:syslog_facility) do
    @doc = 'Configure severity level for syslog facilities'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'Facility'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:level) do
      desc 'Syslog severity level to log'
      munge { |v| Integer(v) }
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'syslog_facility',
    docs: 'Configure severity level for syslog facilities',
    features: ['remote_resource'],
    attributes: {
      ensure: {
        type:    'Enum[present, absent]',
        desc:    'Whether this syslog facility configuration should be present or absent on the target system.',
        default: 'present'
      },
      name: {
        type:   'String',
        desc:   'Facility',
        behaviour: :namevar
      },
      level: {
        type:   'Optional[Integer[0, 7]]',
        desc:   'Syslog severity level to log'
      }
    }
  )
end
