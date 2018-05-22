require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:snmp_notification) do
    @doc = 'Enable or disable notification groups and events'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'The notification name or "all" for all notifications'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:enable) do
      desc 'Enable or disable the notification [true|false]'
      newvalues(:true, :false)
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'snmp_notification',
    docs: 'Enable or disable notification groups and events',
    features: ['remote_resource'],
    attributes: {
      name:           {
        type:       'String',
        desc:       'The notification name or "all" for all notifications',
        behaviour:  :namevar
      },
      enable:         {
        type:      'Optional[Boolean]',
        desc:      'Enable or disable the notification [true|false]'
      }
    }
  )
end
