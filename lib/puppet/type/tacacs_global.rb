require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  # encoding: utf-8

  Puppet::Type.newtype(:tacacs_global) do
    @doc = 'Configure global TACACS settings'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'Resource identifier, not used to manage the device'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:enable) do
      desc 'Enable or disable TACACS functionality [true|false]'
      newvalues(:true, :false)
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

    newproperty(:retransmit_count) do
      desc 'How many times to retransmit'

      validate do |value|
        if value.to_s.match('^\d+$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be a valid integer or 'unset'"
        end
      end
    end

    newproperty(:source_interface, array_matching: :all) do
      desc 'The source interface used for TACACS packets (array of strings for multiple).'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:timeout) do
      desc 'Number of seconds before the timeout period ends'

      validate do |value|
        if value.to_s.match('^\d+$') || value == 'unset' then super(value)
        else raise "value #{value.inspect} is invalid, must be a valid integer or 'unset'"
        end
      end
    end

    newproperty(:vrf, array_matching: :all) do
      desc 'The VRF associated with source_interface (array of strings for multiple).'

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
    name: 'tacacs_global',
    docs: 'Configure global TACACS settings',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      name: {
        type:      'String',
        desc:      'Resource identifier, not used to manage the device',
        behaviour: :namevar,
        default:   'default'
      },
      enable: {
        type:      'Optional[Boolean]',
        desc:      'Enable or disable TACACS functionality [true|false]'
      },
      key: {
        type:      'Optional[String]',
        desc:      'Encryption key (plaintext or in hash form depending on key_format)'
      },
      key_format: {
        type:      'Optional[Variant[Integer, Enum["unset"]]]',
        desc:      'Encryption key format [0-7]'
      },
      retransmit_count: {
        type:      'Optional[Variant[Integer, Enum["unset"]]]',
        desc:      "How many times to retransmit or 'unset' (Cisco Nexus only)"
      },
      source_interface: {
        type:      'Optional[Array[String]]',
        desc:      'The source interface used for TACACS packets (array of strings for multiple).'
      },
      timeout: {
        type:      'Optional[Variant[Integer, Enum["unset"]]]',
        desc:      "Number of seconds before the timeout period ends or 'unset' (Cisco Nexus only)"
      },
      vrf: {
        type:      'Optional[Array[String]]',
        desc:      'The VRF associated with source_interface (array of strings for multiple).'
      }
    }
  )
end
