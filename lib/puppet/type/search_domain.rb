require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:search_domain) do
    @doc = 'Deprecated - use network_dns instead.  DNS suffix to search for FQDN entries.'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      Puppet.warning('search_domain type is deprecated - use network_dns instead.')
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
    docs: 'Deprecated - use network_dns instead.  DNS suffix to search for FQDN entries.',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      ensure: {
        type:       'Enum[present, absent]',
        desc:       'Whether the name server should be present or absent on the target system.',
        default:    'present'
      },
      name: {
        type:      'String',
        desc:      'The search domain to configure in the resolver',
        behaviour: :namevar
      }
    }
  )
end
