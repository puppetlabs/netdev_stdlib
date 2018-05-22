require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:search_domain) do
    @doc = 'Configure the resolver to use the specified search domain'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'The search domain to configure in the resolver'

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
    name: 'search_domain',
    docs: 'Configure the resolver to use the specified search domain',
    features: ['remote_resource'],
    attributes: {
      ensure:       {
        type:       'Enum[present, absent]',
        desc:       'Whether the name server should be present or absent on the target system.',
        default:    'present'
      },
      name:         {
        type:      'String',
        desc:      'The search domain to configure in the resolver',
        behaviour: :namevar
      }
    }
  )
end
