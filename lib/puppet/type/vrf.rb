
require 'puppet/resource_api'
  Puppet::ResourceApi.register_type(
    name: 'vrf',
    docs: 'Configure VRF settings',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      ensure: {
        type:    'Enum[present, absent]',
        desc:    'Whether this VRF should be present or absent on the target system.',
        default: 'present'
      },
      name: {
        type:   'String',
        desc:   'Name of VRF instance',
        behaviour: :namevar
      },
      route_distinguisher: {
        type:   'Optional[String]',
        desc:   'Address qualifier for the VRF, used to amintain uniqueness among identical routes'
      },
      route_targets: {
        type:   'Optional[Array[Tuple[Enum["export", "import", "both"], String]]]',
        desc:   "Address qualifier for the VRF, used to share routes between multiple VRFs"
      },
      import_map: {
        type:   'Optional[String]',
        desc:   'Associates a route map with the VRF'
      }
    }
  )

