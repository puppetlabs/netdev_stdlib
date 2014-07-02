=begin
* Puppet Module  : netdev
* Author         : Jeremy Schulman
* File           : puppet/type/netdev_lag.rb
* Version        : 2012-11-11
* Description    :
*
*    This file contains the Type definition for the network
*    Link Aggregation Group (LAG).
*
=end

Puppet::Type.newtype(:netdev_lag) do
  @doc = "Network Device Link Aggregation Group"

  ensurable
  feature :activable, "The ability to activate/deactive configuration"

  ##### -------------------------------------------------------------
  ##### Parameters
  ##### -------------------------------------------------------------

  newparam( :name, :namevar=>true ) do
    desc "LAG Name"
  end

  ##### -------------------------------------------------------------
  ##### Properties
  ##### -------------------------------------------------------------

  newproperty( :active, :required_features => :activable ) do
    desc "Config activation"
    defaultto( :true )
    newvalues( :true, :false )
  end

  newproperty( :lacp ) do
    desc "LACP [ passive | active | disabled* ]"
    defaultto( :disabled )
    newvalues( :active, :passive, :disabled )
  end

  newproperty( :minimum_links ) do
    desc "Number of active links required for LAG to be 'up'"
    defaultto( 0 )
    munge { |v| Integer( v ) }
  end

  newproperty( :links, :array_matching => :all ) do
    desc "Array of Physical Interfaces"

    munge { |v|  Array( v ) }

    # the order of the array elements is not important
    # so we need to do a sort-compare
    def insync?( is )
      is.sort == @should.sort.map(&:to_s)
    end

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
