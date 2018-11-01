require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:ntp_config) do
    @doc = 'Global configuration for the NTP system'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'Resource name, not used to configure the device'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:authenticate) do
      desc 'NTP authentication enabled [true|false]'
      newvalues(:true, :false)
    end

    newproperty(:source_interface) do
      desc 'The source interface for the NTP system'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:trusted_key, array_matching: :all) do
      desc 'Array of global trusted-keys.  Contents can be a String or Integers'

      validate do |value|
        if (value.is_a? String) || (value.is_a? Integer) then super(value)
        else raise "value #{value.inspect} is invalid, must be a String or Integer."
        end
      end

      def insync?(is)
        is.map(&:to_s).sort == @should.map(&:to_s).sort
      end

      def should_to_s(new_value = @should)
        self.class.format_value_for_display(new_value)
      end

      def is_to_s(current_value = @is)
        self.class.format_value_for_display(current_value)
      end
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'ntp_config',
    docs: 'Specify NTP config',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      name: {
        type:      'String',
        desc:      'Config name, default to "default" as the NTP config is global rather than instance based',
        behaviour: :namevar,
        default:   'default'
      },
      authenticate: {
        type:      'Optional[Boolean]',
        desc:      'NTP authentication enabled [true|false]'
      },
      source_interface: {
        type:      'Optional[String]',
        desc:      'The source interface for the NTP system'
      },
      trusted_key: {
        type:      'Optional[Array[Variant[Integer, String]]]',
        desc:      'Array of global trusted-keys. Contents can be a String or Integers'
      }
    }
  )
end
