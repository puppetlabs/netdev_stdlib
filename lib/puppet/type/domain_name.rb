require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:domain_name) do
    @doc = 'Configure the domain name of the device'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'The domain name of the device'

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
    name: 'domain_name',
    docs: 'Configure the domain name of the device',
    features: ['remote_resource'],
    attributes: {
      ensure:       {
        type:       'Enum[present, absent]',
        desc:       'Whether the name server should be present or absent on the target system.',
        default:    'present'
      },
      name:         {
        type:      'String',
        desc:      'The domain name of the device',
        behaviour: :namevar
      }
    }
  )
end
