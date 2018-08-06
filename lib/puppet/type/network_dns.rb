require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:network_dns) do
    @doc = 'Configure DNS settings for network devices'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'Name, generally "settings", not used to manage the resource'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:domain) do
      desc 'The default domain name to append to the device hostname'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:search, array_matching: :all) do
      desc 'Array of DNS suffixes to search for FQDN entries'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end

      def insync?(is)
        is.sort == @should.sort.map(&:to_s)
      end

      def should_to_s(new_value = @should)
        self.class.format_value_for_display(new_value)
      end

      def is_to_s(current_value = @is)
        self.class.format_value_for_display(current_value)
      end
    end

    newproperty(:servers, array_matching: :all) do
      desc 'Array of DNS servers to use for name resolution'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end

      def insync?(is)
        is.sort == @should.sort.map(&:to_s)
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
    name: 'network_dns',
    docs: 'Configure DNS settings for network devices',
    features: ['remote_resource'],
    attributes: {
      ensure: {
        type:       'Enum[present, absent]',
        desc:       'Whether the network dns should be present or absent on the target system.',
        default:    'present'
      },
      name: {
        type:      'String',
        desc:      'Name, generally "settings", not used to manage the resource',
        behaviour: :namevar,
        default:    'settings'
      },
      domain: {
        type:      'Optional[String]',
        desc:      'The default domain name to append to the device hostname'
      },
      search: {
        type:      'Optional[Array[String]]',
        desc:      'Array of DNS suffixes to search for FQDN entries'
      },
      servers: {
        type:      'Optional[Array[String]]',
        desc:      'Array of DNS servers to use for name resolution'
      }
    }
  )
end
