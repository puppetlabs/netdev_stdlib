require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:radius_global) do
    @doc = 'Configure global RADIUS settings'

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
      desc 'Enable or disable RADIUS functionality [true|false]'
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
      munge { |v| Integer(v) }
    end

    newproperty(:source_interface, array_matching: :all) do
      desc 'The source interface used for RADIUS packets (array of strings for multiple).'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:timeout) do
      desc 'Number of seconds before the timeout period ends'
      munge { |v| Integer(v) }
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
    name: 'radius_global',
    docs: 'Configure global RADIUS settings',
    features: ['remote_resource'],
    attributes: {
      name: {
        type:       'String',
        desc:       'Resource name, not used to manage the device',
        behaviour:  :namevar,
        default:    'default'
      },
      enable: {
        type:      'Optional[Boolean]',
        desc:      'Enable or disable RADIUS functionality [true|false]'
      },
      key: {
        type:      'Optional[String]',
        desc:      'Encryption key (plaintext or in hash form depending on key_format)'
      },
      key_format: {
        type:      'Optional[Integer]',
        desc:      'Encryption key format [0-7]'
      },
      retransmit_count: {
        type:      'Optional[Integer]',
        desc:      'How many times to retransmit'
      },
      source_interface: {
        type:      'Optional[Array[String]]',
        desc:      'The source interface used for RADIUS packets (array of strings for multiple).'
      },
      timeout: {
        type:      'Optional[Integer]',
        desc:      'Number of seconds before the timeout period ends'
      },
      vrf: {
        type:      'Optional[Array[String]]',
        desc:      'The VRF associated with source_interface (array of strings for multiple).'
      }
    }
  )
end
