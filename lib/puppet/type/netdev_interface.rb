=begin
* Puppet Module  : netdev
* Author         : Jeremy Schulman
* File           : puppet/type/netdev_l2_interface.rb
* Version        : 2012-11-11
* Description    : 
*
*    This file contains the Type definition for the network
*    device physical interface.  The network device module 
*    separates the physical port controls from the service 
*    function.  Service controls are defined in their
*    respective type files; e.g. Layer-2 ports are
*    defined in netdev_interface.rb
*
=end

Puppet::Type.newtype(:netdev_interface) do
  @doc = "Network Device Physical Interface"

  ensurable

  ##### -------------------------------------------------------------    
  ##### Parameters
  ##### -------------------------------------------------------------    
  
  newparam( :name, :namevar=>true ) do
    desc "Interface Name"
  end
  
  ##### -------------------------------------------------------------
  ##### Properties
  ##### -------------------------------------------------------------  
  
  newproperty( :active ) do
    desc "Config activation"
    defaultto(:true)
    newvalues(:true, :false)
  end   
  
  newproperty( :admin ) do
    desc "Interface admin state [up*|down]"
    defaultto( :up )
    newvalues( :up, :down )
  end  
  
  newproperty( :description ) do
    desc "Interface physical port description"
  end
  
  newproperty( :mtu ) do
    desc "Maximum Transmission Unit"
    munge { |v| Integer( v ) }
  end
  
  newproperty( :speed ) do
    desc "Link speed [auto*|10m|100m|1g|10g]"
    defaultto( :auto )
    newvalues( :auto,"1g","10g","100m","10m" )    
  end
  
  newproperty( :duplex ) do
    desc "Duplex mode [auto*|full|half]"
    defaultto( :auto )
    newvalues( :auto, :full,:half )    
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
