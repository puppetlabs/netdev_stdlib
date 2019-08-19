require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:banner) do
    @doc = 'Set various banner on a device'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'The banner resource. The name stays as "default"'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:motd) do
      desc 'The MOTD banner'
      munge { |v| String(v) }
    end

    newproperty(:login) do
      desc 'The Login banner'
      munge { |v| String(v) }
    end

    newproperty(:exec) do
      desc 'The EXEC banner'
      munge { |v| String(v) }
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'banner',
    docs: 'Set various banner on a device.',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      name:         {
        type:      'String',
        desc:      'The banner resource. The name stays as "default"',
        behaviour: :namevar,
        default: 'default',
      },
      motd:      {
        type:    'Optional[Variant[String, Enum["unset"]]]',
        desc:    'The MOTD banner',
      },
      login:      {
        type:    'Optional[Variant[String, Enum["unset"]]]',
        desc:    'The Login banner',
      },
      exec:      {
        type:    'Optional[Variant[String, Enum["unset"]]]',
        desc:    'The EXEC banner',
      },
    }
  )
end
