Puppet::Type.newtype(:network_vlan) do
  @doc = "Manage VLAN's.  Layer-2 VLAN's are managed by this resource type."

  ensurable

  feature :describable, "VLAN descriptions are supported by the platform"

  # Parameters (additional data)

  newparam(:name, :namevar=>true) do
    desc <<-EOT
      The resource identifier.  The value does not affect the configuration and
      instead is used to identify this resource within Puppet and related
      tools.
    EOT
  end

  # Properties (state management)

  newproperty(:description, :required_features => :describable) do
    desc "The VLAN Description"
  end

  newproperty(:id) do
    desc "The VLAN ID, e.g. 100"
  end

  newproperty(:shutdown) do
    desc "VLAN shutdown if true, not shutdown if false"
  end
end
