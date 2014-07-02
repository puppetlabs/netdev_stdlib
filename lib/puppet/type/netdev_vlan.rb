=begin
* Puppet Module  : netdev
* Author         : Jeremy Schulman
* File           : puppet/type/netdev_vlan.rb
* Version        : 2012-11-11
* Description    :
*
*    This file contains the Type definition for the network
*    device Vlan resource.
*
=end

Puppet::Type.newtype(:netdev_vlan) do
  @doc = "Network Device VLAN"

  ensurable
  feature :activable, "The ability to activate/deactive configuration"
  feature :describable, "The ability to add a description"
  feature :no_mac_learning, "The ability disable MAC learning"

  ##### -------------------------------------------------------------
  ##### Parameters
  ##### -------------------------------------------------------------

  newparam(:name, :namevar=>true) do
    desc "The VLAN name"
  end

  ##### -------------------------------------------------------------
  ##### Properties
  ##### -------------------------------------------------------------

  newproperty(:active, :required_features => :activable) do
    desc "Config activation"
    defaultto(:true)
    newvalues(:true, :false)
  end

  newproperty(:description, :required_features => :describable) do
    desc "The VLAN Description"
  end

  newproperty(:vlan_id) do
    desc "The VLAN ID"
  end

  newproperty(:no_mac_learning, :required_features => :no_mac_learning) do
    desc "Do not learn MAC addresses; used for 2-port VLANs"
    defaultto(:false)
    newvalues(:true, :false)
  end

  ##### -------------------------------------------------------------
  ##### Auto require the netdev_device resource -
  #####   There must be one netdev_device resource defined in the
  #####   catalog, it doesn't matter what the name of the device is,
  #####   just that one exists.
  ##### -------------------------------------------------------------

  autorequire(:netdev_device) do
    netdev = catalog.resources.select{ |r| r.type == :netdev_device }[0]
    raise "No netdev_device found in catalog" unless netdev
    netdev.title   # returns the name of the netdev_device resource
  end

end
