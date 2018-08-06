require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:network_vlan) do
    @doc = "Manage VLAN's.  Layer-2 VLAN's are managed by this resource type."

    apply_to_all
    ensurable

    feature :describable, 'The ability to add a description to a VLAN.'

    # Parameters

    newparam(:id, namevar: true) do
      desc 'The VLAN ID, e.g. 100'

      # Make sure we have a string for the ID
      munge do |value|
        Integer(value).to_s
      end
    end

    # Properties (state management)

    newproperty(:vlan_name) do
      desc 'The VLAN name, e.g. VLAN100'

      validate do |value|
        case value
        when String
          super(value)
          validate_features_per_value(value)
        else raise "value #{value.inspect} is invalid, must be a string."
        end
      end
    end

    newproperty(:shutdown) do
      desc 'VLAN shutdown if true, not shutdown if false'
      newvalues(:true, :false)
    end

    newproperty(:description, required_features: ['describable']) do
      desc "The VLAN Description, e.g. 'Engineering'"

      validate do |value|
        case value
        when String
          super(value)
          validate_features_per_value(value)
        else raise "value #{value.inspect} is invalid, must be a string."
        end
      end
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'network_vlan',
    docs: "Manage VLAN's.  Layer-2 VLAN's are managed by this resource type.",
    features: ['remote_resource'],
    attributes: {
      ensure: {
        type:    'Enum[present, absent]',
        desc:    'Whether this VLAN should be present or absent on the target system.',
        default: 'present'
      },
      id: {
        type:   'String',
        desc:   'The VLAN ID',
        behaviour: :namevar
      },
      vlan_name: {
        type:   'Optional[String]',
        desc:   'The VLAN name'
      },
      shutdown: {
        type:      'Optional[Boolean]',
        desc:      'VLAN shutdown if true, not shutdown if false [true|false]',
        default:   false
      },
      description: {
        type:   'Optional[String]',
        desc:   "The VLAN Description, e.g. 'Engineering'"
      }
    }
  )
end
