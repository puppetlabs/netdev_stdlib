# OVERVIEW

Netdev is a vendor-neutral network abstraction framework developed by Juniper Networks and contributed freely to the DevOps community

# EXAMPLE USAGE

This module has been tested against Puppet agent 2.7.19.  

Here is a short example illustrating a multi-vendor use-case.  Both switch vendors are using the same configuration class definition "puppet_switch_demo".  The VLAN definitions are being sourced from a YAML file that mirrors the netdev_vlan properies.  The device specific port information is wrapped up in another class that examines the Facter 'osfamily' fact.

~~~~
class puppet_switch_ports {
      
   case $osfamily {
     JUNOS: {
       $db_port = "ge-0/0/0"
       $web_port = "ge-0/0/1"
       $uplink_lag = "ae0"
       $uplink_lag_ports = [ 'ge-0/0/2', 'ge-0/0/3' ]
     }
     EOS: {
       $db_port = "Ethernet1"
       $web_port = "Ethernet2"
       $uplink_lag = "Port-Channel1"
       $uplink_lag_ports = [ 'Ethernet3', 'Ethernet4' ]
     }
   }
      
   $all_ports = [ $db_port, $web_port, $uplink_lag_ports ]      
}

class puppet_switch_demo {
      
   netdev_device { $hostname: }     
   
   include puppet_switch_ports
   
   $vlans = loadyaml( "$DATADIR/vlans.yaml" )
   create_resources( netdev_vlan, $vlans ) 
   
   netdev_interface { $puppet_switch_ports::all_ports:
      admin => up
   }

   netdev_l2_interface { $puppet_switch_ports::db_port:
      untagged_vlan => Blue
   }
   
   netdev_l2_interface{ $puppet_switch_ports::web_port:
      untagged_vlan => Green
   }
   
   netdev_l2_interface { $puppet_switch_ports::uplink_lag_ports: 
      ensure => absent 
   }->   
   netdev_lag { $puppet_switch_ports::uplink_lag:
      links => $puppet_switch_ports::uplink_lag_ports 
   }->   
   netdev_l2_interface { $puppet_switch_ports::uplink_lag: 
      tagged_vlans => keys( $vlans )
   }      
   
}

node "veos01.workflowsherpas.com" {
   include puppet_switch_demo
}

node "ex4200.workflowsherpas.com" { 
   include puppet_switch_demo
}
~~~~
  
# DEPENDENCIES

  * Puppet 2.7.19

# INSTALLATION ON PUPPET-MASTER

  * puppet module install netdevops/netdev_stdlib 

# RESOURCE TYPES

  See RESOURCE-STDLIB.md for documentation and usage examples

# CONTRIBUTORS

  * Jeremy Schulman, @nwkautomaniac
  * Derick Winkworth, @cloudtoad
  * Peter Sprygada, @privateip

# LICENSES

   BSD-2, See LICENSE file
