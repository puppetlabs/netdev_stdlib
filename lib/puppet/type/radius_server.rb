require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:radius_server) do
    @doc = 'Configure a RADIUS server'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'The name of the RADIUS server'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:hostname) do
      desc 'The hostname or address of the RADIUS server'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:auth_port) do
      desc 'Port number to use for authentication'
      munge { |v| Integer(v) }
    end

    newproperty(:acct_port) do
      desc 'Port number to use for accounting'
      munge { |v| Integer(v) }
    end

    newproperty(:key) do
      desc 'Encryption key (plaintext or in hash form depending on key_format)'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:key_format) do
      desc 'Encryption key format [0-7]'
      munge { |v| Integer(v) }
    end

    newproperty(:group) do
      desc 'Server group associated with this server'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:deadtime) do
      desc 'Number of minutes to ignore an unresponsive server'
      munge { |v| Integer(v) }
    end

    newproperty(:timeout) do
      desc 'Number of seconds before the timeout period ends'
      munge { |v| Integer(v) }
    end

    newproperty(:vrf) do
      desc 'VRF to send syslog data from, e.g. "management"'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:source_interface) do
      desc 'Source interface to send syslog data from, e.g. "ethernet 2/1"'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:retransmit_count) do
      desc 'How many times to retransmit'
      munge { |v| Integer(v) }
    end

    newproperty(:accounting_only) do
      desc 'Enable this server for accounting only'
      newvalues(:true, :false)
    end

    newproperty(:authentication_only) do
      desc 'Enable this server for authentication only'
      newvalues(:true, :false)
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'radius_server',
    docs: 'Configure a RADIUS server',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      ensure: {
        type:    'Enum[present, absent]',
        desc:    'Ensure the radius_server exists.',
        default: 'present'
      },
      name: {
        type:       'String',
        desc:       'The name of the RADIUS server',
        behaviour:  :namevar
      },
      hostname: {
        type:      'Optional[String]',
        desc:      'The hostname or address of the RADIUS server'
      },
      auth_port: {
        type:      'Optional[Integer[1, 65535]]',
        desc:      'Port number to use for authentication'
      },
      acct_port: {
        type:      'Optional[Integer[1, 65535]]',
        desc:      'Port number to use for accounting'
      },
      key: {
        type:      'Optional[String]',
        desc:      'Encryption key (plaintext or in hash form depending on key_format)'
      },
      key_format: {
        type:      'Optional[Integer]',
        desc:      'Encryption key format [0-7]'
      },
      group: {
        type:      'Optional[String]',
        desc:      'Server group associated with this server'
      },
      deadtime: {
        type:      'Optional[Integer]',
        desc:      'Number of minutes to ignore an unresponsive server'
      },
      timeout: {
        type:      'Optional[Integer]',
        desc:      'Number of seconds before the timeout period ends'
      },
      vrf: {
        type:      'Optional[String]',
        desc:      'VRF to send syslog data from, e.g. "management"'
      },
      source_interface: {
        type:      'Optional[String]',
        desc:      'Source interface to send syslog data from, e.g. "ethernet 2/1"'
      },
      retransmit_count: {
        type:      'Optional[Integer]',
        desc:      'How many times to retransmit'
      },
      accounting_only: {
        type:      'Optional[Boolean]',
        desc:      'Enable this server for accounting only'
      },
      authentication_only: {
        type:      'Optional[Boolean]',
        desc:      'Enable this server for authentication only'
      }
    }
  )
end
