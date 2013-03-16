=begin
* Puppet Module  : netdev
* Author         : Jeremy Schulman
* File           : puppet/type/netdev_l2_interface.rb
* Version        : 2012-11-11
* Description    : 
*
*    This file contains the Type definition for the network
*    device layer-2 interface (i.e. switch port).  The
*    network device module separates the physical port
*    controls from the service function.  Physical port
*    controls are defined in netdev_interface.rb
*
=end

Puppet::Type.newtype(:netdev_l2_interface) do
  
  @doc = "Ethernet layer2 (switch-port) interface"
  
  ensurable
  
  ##### -------------------------------------------------------------
  ##### Parameters
  ##### -------------------------------------------------------------  
  
  newparam(:name, :namevar=>true) do
    desc "The switch interface name"
  end
  
  ##### -------------------------------------------------------------
  ##### Properties
  ##### -------------------------------------------------------------  
  
  newproperty(:active) do
    desc "Config activation"
    defaultto(:true)
    newvalues(:true, :false)
  end   
  
  newproperty(:vlan_tagging) do
    desc "The switch interface vlan-tagging mode"
    defaultto(:disable)
    newvalues(:enable,:disable)     
  end
  
  newproperty(:description) do
    desc "The switch interface description."
  end
  
  newproperty(:tagged_vlans, :array_matching => :all) do
    desc "Array of VLAN names used for tagged packets"
    defaultto([])
    munge{ |v| Array(v) }
    
    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end
    
    def should_to_s( value )
      "[" + value.join(',') + "]"
    end
    def is_to_s( value )
      "[" + value.join(',') + "]"
    end
    
  end
  
  newproperty(:untagged_vlan) do
    desc "VLAN used for untagged packets"
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
    
  autorequire(:netdev_vlan) do    
    vlans = self[:tagged_vlans] || []
    vlans << self[:untagged_vlan] if self[:untagged_vlan]
    vlans.flatten
  end    
  
end
