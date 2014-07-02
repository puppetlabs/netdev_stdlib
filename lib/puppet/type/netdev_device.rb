=begin
* Puppet Module  : netdev
* Author         : Jeremy Schulman
* File           : puppet/type/netdev_device.rb
* Version        : 2012-11-11
* Description    :
*
*    This file contains the Type definition for the network
*    device.  This type exists so that the network device
*    resource can auto-require and create a dependency.  If
*    the network device is not available for any reason, then
*    the network device resources should not be processed.
*
=end

Puppet::Type.newtype(:netdev_device) do
  @doc = "Network device resource to support autorequire relationships"

  ensurable

  ##### -------------------------------------------------------------
  ##### Parameters
  ##### -------------------------------------------------------------

  newparam(:name, :namevar=>true) do
    desc "The network device name can be any placeholder value"
  end
end
