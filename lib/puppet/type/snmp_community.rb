require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:snmp_community) do
    @doc = 'Manage the SNMP community'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'The name of the community, e.g. "public" or "private"'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:group) do
      desc 'The SNMP group for this community'
      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:acl) do
      desc 'The ACL name to associate with this community string'
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
    name: 'snmp_community',
    docs: 'Manage the SNMP community',
    features: ['remote_resource'],
    attributes: {
      ensure:       {
        type:       'Enum[present, absent]',
        desc:       'Whether the SNMP Community should be present or absent on the target system.',
        default:    'present'
      },
      name:           {
        type:       'String',
        desc:       'The name of the community, e.g. "public" or "private"',
        behaviour:  :namevar
      },
      group:           {
        type:       'Optional[String]',
        desc:       'The SNMP group for this community'
      },
      acl:           {
        type:       'Optional[String]',
        desc:       'The ACL name to associate with this community string'
      }
    }
  )
end
