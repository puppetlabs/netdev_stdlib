require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:network_snmp) do
    @doc = 'Manage snmp location, contact and enable SNMP on the device'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'The name of the Puppet resource, not used to manage the device'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:enable) do
      desc 'Enable or disable SNMP functionality [true|false]'
      newvalues(:true, :false)
    end

    newproperty(:contact) do
      desc 'The contact name for this device'
      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:location) do
      desc 'The location of this device'
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
    name: 'network_snmp',
    docs: 'Manage snmp location, contact and enable SNMP on the device',
    features: ['remote_resource'],
    attributes: {
      name:     {
        type:       'String',
        desc:       'Name, generally "default", not used to manage the resource',
        default:    'default',
        behaviour:  :namevar
      },
      enable:    {
        type:   'Optional[Boolean]',
        desc:   'Enable or disable SNMP functionality [true|false]'
      },
      contact:    {
        type:   'Optional[String]',
        desc:   'The contact name for this device'
      },
      location:    {
        type:   'Optional[String]',
        desc:   'The location of this device'
      }
    }
  )
end
