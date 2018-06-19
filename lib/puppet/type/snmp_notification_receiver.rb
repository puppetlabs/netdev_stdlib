require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:snmp_notification_receiver) do
    @doc = 'Manage an SNMP notification receiver'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'Hostname or IP address of the receiver'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:port) do
      desc 'SNMP UDP port number'
      munge { |v| Integer([*v].first) }
    end

    newproperty(:username) do
      desc 'Username to use for SNMPv3 privacy and authentication.  This is the'\
        'community string for SNMPv1 and v2'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:version) do
      desc 'SNMP version [v1|v2|v2c|v3]'
      newvalues(:v1, :v2, :v2c, :v3)
    end

    newproperty(:type) do
      desc 'The type of receiver [traps|informs]'
      newvalues(:traps, :informs)
    end

    newproperty(:security) do
      desc 'SNMPv3 security mode'
      newvalues(:auth, :noauth, :priv)
    end

    newproperty(:vrf) do
      desc 'VRF to send SNMP data from, e.g. "management"'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:source_interface) do
      desc 'Source interface to send SNMP data from, e.g. "ethernet 2/1"'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    def self.title_patterns
      identity = nil # optimization in Puppet core
      name = [:name, identity]
      username = [:username, identity]
      port = [:port, ->(x) { Integer(x) }]
      [
        [/^([^:]*)$/,                 [name]],
        [/^([^:]*):([^:]*)$/,         [name, username]],
        [/^([^:]*):([^:]*):([^:]*)$/, [name, username, port]]
      ]
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'snmp_notification_receiver',
    docs: 'Manage an SNMP notification receiver',
    features: ['remote_resource'],
    attributes: {
      ensure:       {
        type:       'Enum[present, absent]',
        desc:       'Whether the SNMP notification receiver should be present or absent on the target system.',
        default:    'present'
      },
      # TODO: NETDEV-36: composite namevars
      name:           {
        type:       'String',
        desc:       'Composite ID of name / username / port (if applicable)',
        behaviour:  :namevar
      },
      port:          {
        type:      'Optional[Integer[1, 65535]]',
        desc:      'SNMP UDP port number'
      },
      username:      {
        type:      'Optional[String]',
        desc:      'Username to use for SNMPv3 privacy and authentication. This is the community string for SNMPv1 and v2'
      },
      version:      {
        type:      'Optional[Enum["v1","v2","v2c","v3"]]',
        desc:      'SNMP version [v1|v2|v2c|v3]'
      },
      type:       {
        type:      'Optional[Enum["traps","informs"]]',
        desc:      'The type of receiver [traps|informs]'
      },
      security:     {
        type:      'Optional[Enum["auth","noauth","priv"]]',
        desc:      'SNMPv3 security mode [auth|noauth|priv]'
      },
      vrf:          {
        type:      'Optional[String]',
        desc:      'VRF to send SNMP data from, e.g. "management"'
      },
      source_interface:          {
        type:      'Optional[String]',
        desc:      'Source interface to send SNMP data from, e.g. "ethernet 2/1"'
      }
    }
  )
end
