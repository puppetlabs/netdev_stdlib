require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:banner) do
    @doc = 'Set various banner on a device'

    apply_to_all

    newparam(:name, namevar: true) do
      desc 'The banner resource. The name stays as "default"'
      newvalues(:default)
    end

    newproperty(:motd) do
      desc 'The MOTD banner'
      munge { |v| String(v) }
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'banner',
    docs: 'Set various banner on a device.',
    features: ['remote_resource'],
    attributes: {
      name:         {
        type:      'String',
        desc:      'The banner resource. The name stays as "default"',
        behaviour: :namevar,
        default: 'default',
      },
      motd:      {
        type:    'String',
        desc:    'The MOTD banner',
      },
    }
  )
end
