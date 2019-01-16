# Network Device Standard Library

[![Build Status][buildstatus]][travis]

# Overview

This module implements the type specification for the network device support
program.  The goal of this module is to provide the Puppet types for writing
provider implementations of these types for a specific network device model.

The modules supports legacy Puppet and [Resource API](https://github.com/puppetlabs/puppet-resource_api) versions of the types.

Both versions of the types perform the same in the catalog, but stricter type checking is enabled with RSAPI versions.

Only one version can be loaded into an environment at a time.  On the master, RSAPI version of the types will always be loaded when Resource API gem is present.  This will be the default behavior in future versions of Puppet.

On the agent, legacy types will be loaded if the operatingsystem is `aristaeos or ios_xr`, otherwise RSAPI version is loaded.

# Reference Information

The following reference material is useful when developing providers for the
types implemented in this module.

 * [Resource API](https://github.com/puppetlabs/puppet-resource_api)
 * [Puppet Types and Providers by Dan Bode & Nan Liu][book]
 * [Custom Types Documentation][types doc]
 * [Seriously, What is this Provider Doing?][gary provider] Useful for an
   in-depth explanation of the instances class method for each provider.

# Reference
## Resource types
* [`banner`](#banner): Configure banners for network devices
* [`network_dns`](#network_dns): Configure DNS settings for network devices
* [`network_interface`](#network_interface): Manage physical network interfaces, e.g. Ethernet1
* [`network_snmp`](#network_snmp): Manage snmp location, contact and enable SNMP on the device
* [`network_trunk`](#network_trunk): Ethernet logical (switch-port) interface.  Configures VLAN trunking.
* [`network_vlan`](#network_vlan): Manage VLAN's.  Layer-2 VLAN's are managed by this resource type.
* [`ntp_auth_key`](#ntp_auth_key): NTP Authentication keys
* [`ntp_config`](#ntp_config): Global configuration for the NTP system
* [`ntp_server`](#ntp_server): Specify an NTP server
* [`port_channel`](#port_channel): Network Device Link Aggregation Group
* [`radius`](#radius): Enable or disable radius functionality
* [`radius_global`](#radius_global): Configure global radius settings
* [`radius_server`](#radius_server): Configure a radius server
* [`radius_server_group`](#radius_server_group): Configure a radius server group
* [`snmp_community`](#snmp_community): Manage the SNMP community
* [`snmp_notification`](#snmp_notification): Enable or disable notification groups and events
* [`snmp_notification_receiver`](#snmp_notification_receiver): Manage an SNMP notification receiver
* [`snmp_user`](#snmp_user): Set the SNMP contact name
* [`syslog_facility`](#syslog_facility): Configure severity levels for global syslog facilities
* [`syslog_server`](#syslog_server): Configure a remote syslog server for logging
* [`syslog_settings`](#syslog_settings): Configure global syslog settings
* [`tacacs`](#tacacs): Enable or disable tacacs functionality
* [`tacacs_global`](#tacacs_global): Configure global tacacs settings
* [`tacacs_server`](#tacacs_server): Configure a tacacs server
* [`tacacs_server_group`](#tacacs_server_group): Configure a tacacs server group

## Deprecated resource types
The following types have been replaced by [`network_dns`](#network_dns)
* [`domain_name`](#domain_name): Default domain name to append to the device hostname
* [`name_server`](#name_server): Configure the resolver to use the specified DNS server
* [`search_domain`](#search_domain): DNS suffix to search for FQDN entries

#### banner

Set various banners on the device, for example motd.

##### attributes

The following attributes are available in the `banner` type.

###### `name`

namevar

The friendly name for banner settings, it is set to default.

Default value: default.

###### `motd`

The MOTD banner.

#### domain_name

Deprecated - Default domain name to append to the device hostname.


##### Properties

The following properties are available in the `domain_name` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

##### Parameters

The following parameters are available in the `domain_name` type.

###### `name`

namevar

The domain name of the device.


#### name_server

Deprecated - Configure the resolver to use the specified DNS server.


##### Properties

The following properties are available in the `name_server` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

##### Parameters

The following parameters are available in the `name_server` type.

###### `name`

namevar

The hostname or address of the DNS server.


#### network_dns

Configure DNS settings for network devices.


##### Properties

The following properties are available in the `network_dns` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `domain`

The default domain name to add to the device hostname.

###### `hostname`

The hostname of the device

###### `search`

Array of DNS suffixes to search for FQDN entries.

###### `servers`

Array of DNS servers to use for name resolution.

##### Parameters

The following parameters are available in the `network_dns` type.

###### `name`

namevar

Name, generally "settings". Not used to manage the resource.


#### network_interface

Manage physical network interfaces, for example, Ethernet1.


##### Properties

The following properties are available in the `network_interface` type.

###### `enable`

Valid values: `true`, `false`

Enable the interface, true or false.

###### `description`

Interface physical port description.

###### `mtu`

Interface Maximum Transmission Unit in bytes.

###### `speed`

Valid values: auto, 1g, 10g, 40g, 56g, 100g, 100m, 10m.

Link speed [auto*|10m|100m|1g|10g|40g|56g|100g].

###### `duplex`

Valid values: auto, full, half.

Duplex mode [auto*|full|half].

##### Parameters

The following parameters are available in the `network_interface` type.

###### `name`

namevar

Interface Name, for example, Ethernet1.


#### network_snmp

Manage snmp location. Contact and enable SNMP on the device.


##### Properties

The following properties are available in the `network_snmp` type.

###### `enable`

Valid values: `true`, `false`

Enable or disable SNMP functionality [true|false].

###### `contact`

The contact name for this device.

###### `location`

The location of this device.

##### Parameters

The following parameters are available in the `network_snmp` type.

###### `name`

namevar

The name of the Puppet resource — not used to manage the device.


#### network_trunk

Ethernet logical (switch-port) interface.  Configures VLAN trunking.


##### Properties

The following properties are available in the `network_trunk` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `encapsulation`

Valid values: dot1q, isl, negotiate, none.

The vlan-tagging encapsulation protocol, usually dot1q.

###### `mode`

Valid values: access, trunk, dynamic_auto, dynamic_desirable.

The L2 interface mode, enables or disables trunking.

###### `untagged_vlan`

VLAN used for untagged VLAN traffic. a.k.a Native VLAN.

###### `tagged_vlans`

Array of VLAN names used for tagged packets.

###### `pruned_vlans`

Array of VLAN ID numbers used for VLAN pruning.

##### Parameters

The following parameters are available in the `network_trunk` type.

###### `name`

namevar

The switch interface name, for example, Ethernet1.


#### network_vlan

Manage VLAN's.  Layer-2 VLAN's are managed by this resource type.


##### Properties

The following properties are available in the `network_vlan` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `vlan_name`

The VLAN name, for example, VLAN100.

###### `shutdown`

Valid values: `true`, `false`

VLAN shutdown if true, not shutdown if false.

###### `description`

The VLAN Description, for example, 'Engineering'.

##### Parameters

The following parameters are available in the `network_vlan` type.

###### `id`

The VLAN ID, for example, 100.


#### ntp_auth_key

NTP Authentication keys.


##### Properties

The following properties are available in the `ntp_auth_key` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `algorithm`

Valid values: md5, sha1, sha256.

Hash algorithm [md5|sha1|sha256].

###### `mode`

Password mode [0 (plain) | 7 (encrypted)].

###### `password`

Password text

##### Parameters

The following parameters are available in the `ntp_auth_key` type.

###### `name`

namevar

Authentication key ID.


#### ntp_config

Global configuration for the NTP system.


##### Properties

The following properties are available in the `ntp_config` type.

###### `authenticate`

Valid values: `true`, `false`.

NTP authentication enabled [true|false].

###### `source_interface`

The source interface for the NTP system.

###### `trusted_key`

Array of global trusted-keys. Contents can be a String or Integers.

##### Parameters

The following parameters are available in the `ntp_config` type.

###### `name`

namevar

Resource name — not used to configure the device.


#### ntp_server

Specify an NTP server.


##### Properties

The following properties are available in the `ntp_server` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `key`

Authentication key ID.

###### `maxpoll`

The maximul poll interval.

###### `minpoll`

The minimum poll interval.

###### `prefer`

Valid values: `true`, `false`.

Prefer this NTP server [true|false].

###### `source_interface`

The source interface used to reach the NTP server.

###### `vrf`

The VRF instance this server is bound to.

##### Parameters

The following parameters are available in the `ntp_server` type.

###### `name`

namevar

The hostname or address of the NTP server.


#### port_channel

Network Device Link Aggregation Group.


##### Properties

The following properties are available in the `port_channel` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `id`

Channel Group ID, for example, 10.

###### `description`

Port Channel description.

###### `mode`

Valid values: active, passive, disabled.

LACP mode [ passive | active | disabled* ]

###### `interfaces`

Array of Physical Interfaces.

###### `minimum_links`

Number of active links required for LAG to be up.

###### `speed`

Valid values: auto, 1g, 10g, 40g, 56g, 100g, 100m, 10m.

Link speed [auto*|10m|100m|1g|10g|40g|56g|100g].

###### `duplex`

Valid values: auto, full, half.

Duplex mode [auto*|full|half].

###### `flowcontrol_send`

Valid values: desired, on, off.

Flow control (send) [desired|on|off].

###### `flowcontrol_receive`

Valid values: desired, on, off.

Flow control (receive) [desired|on|off].

##### Parameters

The following parameters are available in the `port_channel` type.

###### `name`

namevar

LAG Name.

###### `force`

Valid values: `true`, `false`

Force configuration (true / false).


#### radius

Enable or disable radius functionality.


##### Properties

The following properties are available in the `radius` type.

###### `enable`

Valid values: `true`, `false`

Enable or disable radius functionality [true|false].

##### Parameters

The following parameters are available in the `radius` type.

###### `name`

namevar

Resource name — not used to manage the device.


#### radius_global

Configure global radius settings.


##### Properties

The following properties are available in the `radius_global` type.

###### `enable`

Valid values: `true`, `false`.

Enable or disable radius functionality [true|false].

###### `key`

Encryption key (plaintext or in hash form depending on key_format).

###### `key_format`

Encryption key format [0-7].

###### `retransmit_count`

How many times to retransmit or 'unset' (Cisco Nexus only)

###### `source_interface`

The source interface used for RADIUS packets (array of strings for multiple).

###### `timeout`

Number of seconds before the timeout period ends or 'unset' (Cisco Nexus only)f

###### `vrf`

The VRF associated with source_interface (array of strings for multiple).

##### Parameters

The following parameters are available in the `radius_global` type.

###### `name`

namevar

Resource identifier — not used to manage the device.


#### radius_server

Configure a radius server.


##### Properties

The following properties are available in the `radius_server` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `hostname`

The hostname or address of the radius server.

###### `auth_port`

Port number to use for authentication.

###### `acct_port`

Port number to use for accounting.

###### `key`

Encryption key (plaintext or in hash form depending on key_format).

###### `key_format`

Encryption key format [0-7].

###### `group`

Server group associated with this server.

###### `deadtime`

Number of minutes to ignore an unresponsive server.

###### `timeout`

Number of seconds before the timeout period ends.

###### `vrf`

Interface to send syslog data from, for example, "management".

###### `source_interface`

Source interface to send syslog data from, for example, "ethernet 2/1".

###### `retransmit_count`

How many times to retransmit.

###### `accounting_only`

Valid values: `true`, `false`.

Enable this server for accounting only.

###### `authentication_only`

Valid values: `true`, `false`.

Enable this server for authentication only.

##### Parameters

The following parameters are available in the `radius_server` type.

###### `name`

namevar

The name of the radius server.


#### radius_server_group

Configure a radius server group.


##### Properties

The following properties are available in the `radius_server_group` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `servers`

Array of servers associated with this group.

##### Parameters

The following parameters are available in the `radius_server_group` type.

###### `name`

namevar

The name of the radius server group.


#### search_domain

Deprecated - DNS suffix to search for FQDN entries.


##### Properties

The following properties are available in the `search_domain` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

##### Parameters

The following parameters are available in the `search_domain` type.

###### `name`

namevar

The search domain to configure in the resolver.


#### snmp_community

Manage the SNMP community.


##### Properties

The following properties are available in the `snmp_community` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `group`

The SNMP group for this community.

###### `acl`

The ACL name to associate with this community string.

##### Parameters

The following parameters are available in the `snmp_community` type.

###### `name`

namevar

The name of the community, for example, "public" or "private".


#### snmp_notification

Enable or disable notification groups and events.


##### Properties

The following properties are available in the `snmp_notification` type.

###### `enable`

Valid values: `true`, `false`.

Enable or disable the notification [true|false].

##### Parameters

The following parameters are available in the `snmp_notification` type.

###### `name`

namevar

The notification name or "all" for all notifications.


#### snmp_notification_receiver

Manage an SNMP notification receiver.


##### Properties

The following properties are available in the `snmp_notification_receiver` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `port`

SNMP UDP port number.

###### `username`



###### `version`

Valid values: v1, v2, v3.

SNMP version [v1|v2|v3].

###### `type`

Valid values: traps, informs.

The type of receiver [traps|informs].

###### `security`

Valid values: auth, noauth, priv.

SNMPv3 security mode.

###### `vrf`

Interface to send SNMP data from, for example, "management".

###### `source_interface`

Source interface to send SNMP data from, for example, "ethernet 2/1".

##### Parameters

The following parameters are available in the `snmp_notification_receiver` type.

###### `name`

namevar

Hostname or IP address of the receiver.


#### snmp_user

Set the SNMP contact name.


##### Properties

The following properties are available in the `snmp_user` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `version`

Valid values: v1, v2, v2c, v3.

SNMP version [v1|v2|v2c|v3].

###### `roles`

A list of roles associated with this SNMP user.

###### `auth`

Valid values: md5, sha.

Authentication mode [md5|sha].

###### `password`

Cleartext password for the user.

###### `privacy`

Valid values: aes128, des

Privacy encryption method [aes128|des].

###### `private_key`

Private key in hexadecimal string.

###### `engine_id`

Necessary if the SNMP engine is encrypting data.

##### Parameters

The following parameters are available in the `snmp_user` type.

###### `name`

namevar

The name of the SNMP user.

###### `localized_key`

Valid values: `true`, `false`

If true, password needs to be a hexadecimal value.

###### `enforce_privacy`

Valid values: `true`, `false`

If true, message encryption is enforced.


#### syslog_facility

Configure severity levels for global syslog facilities.


##### Properties

The following properties are available in the `syslog_facility` type.

###### `level`

Syslog severity level to log.

##### Parameters

The following parameters are available in the `syslog_facility` type.

###### `name`

namevar

Global facility to manage


#### syslog_server

Configure a remote syslog server for logging.


##### Properties

The following properties are available in the `syslog_server` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `port`

Port number of remote syslog server.

###### `severity_level`

Syslog severity level to log.

###### `vrf`

Interface to send syslog data from, for example, "management".

###### `source_interface`

Source interface to send syslog data from, for example, "ethernet 2/1".

##### Parameters

The following parameters are available in the `syslog_server` type.

###### `name`

namevar

The hostname or address of the remote syslog server.


#### syslog_settings

Configure global syslog settings.


##### Properties

The following properties are available in the `syslog_settings` type.

###### `enable`

Valid values: `true`, `false`.

Enable or disable syslog logging [true|false].

###### `console`

Console logging severity level [0-7] or 'unset'.

###### `monitor`

Monitor (terminal) logging severity level [0-7] or 'unset'.

###### `source_interface`

Source interface to send syslog data from, for example, "ethernet 2/1" (array of strings for multiple).

###### `time_stamp_units`

Valid values: seconds, milliseconds.

The unit to log time values in.

###### `vrf`

The VRF associated with source_interface (array of strings for multiple).

###### `logfile_severity_level`

Logfile severity level [0-7] or 'unset'

###### `logfile_name`

Logfile file name to use or 'unset'

###### `logfile_size`

Logging file maximum size or 'unset'

###### `buffered_severity_level`

Buffered log severity level [0-7] or 'unset'

###### `buffered_size`

Logging buffer size or 'unset'

##### Parameters

The following parameters are available in the `syslog_settings` type.

###### `name`

namevar

Resource name — not used to configure the device.


#### tacacs

Enable or disable tacacs functionality.


##### Properties

The following properties are available in the `tacacs` type.

###### `enable`

Valid values: `true`, `false`.

Enable or disable tacacs functionality [true|false].

##### Parameters

The following parameters are available in the `tacacs` type.

###### `name`

namevar

Resource name — not used to manage the device.


#### tacacs_global

Configure global tacacs settings.


##### Properties

The following properties are available in the `tacacs_global` type.

###### `enable`

Valid values: `true`, `false`.

Enable or disable radius functionality [true|false].

###### `key`

Encryption key (plaintext or in hash form depending on key_format).

###### `key_format`

Encryption key format [0-7].

###### `retransmit_count`

How many times to retransmit or 'unset' (Cisco Nexus only)

###### `source_interface`

The source interface used for TACACS packets (array of strings for multiple).

###### `timeout`

Number of seconds before the timeout period ends or 'unset' (Cisco Nexus only)

###### `vrf`

The VRF associated with source_interface (array of strings for multiple).

##### Parameters

The following parameters are available in the `tacacs_global` type.

###### `name`

namevar

Resource identifier — not used to manage the device.


#### tacacs_server

Configure a tacacs server.


##### Properties

The following properties are available in the `tacacs_server` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present.

###### `hostname`

The hostname or address of the tacacs server.

###### `single_connection`

Valid values: `true`, `false`

Enable or disable session multiplexing [true|false].

###### `vrf`

Specifies the VRF instance used to communicate with the server.

###### `port`

The port of the tacacs server.

###### `key`

Encryption key (plaintext or in hash form depending on key_format).

###### `key_format`

Encryption key format [0-7].

###### `timeout`

Number of seconds before the timeout period ends.

###### `group`

Server group associated with this server.

##### Parameters

The following parameters are available in the `tacacs_server` type.

###### `name`

namevar

The name of the tacacs server group.


#### tacacs_server_group

Configure a tacacs server group.


##### Properties

The following properties are available in the `tacacs_server_group` type.

###### `ensure`

Valid values: present, absent.

The basic property that the resource should be in.

Default value: present

###### `servers`

Array of servers associated with this group.

##### Parameters

The following parameters are available in the `tacacs_server_group` type.

###### `name`

namevar

The name of the tacacs server group.

# Getting Started for Development

This section describes how to get started developing providers for the types
implemented in this module.

First, configure a Ruby development environment.  There are multiple ways to
accomplish this task including [rvm][rvm], [rbenv][rbenv], and
[crossfader][crossfader].  This module has been developed using
[crossfader][crossfader], a pre-packaged build of multiple Ruby versions
specifically designed for developing and extending Puppet.

## Install Crossfader

Please follow the [Crossfader Quick Start][crossfader quick start] instructions
to get started with crossfader on Mac OS X.

## Set the ruby environment

Once crossfader is installed, select the version of Ruby currently shipping
with Puppet Enterprise.  At the time of writing this is currently Ruby
1.9.3-p484.  Information on the current version of Ruby shipping with Puppet
Enterprise is available at [Puppet Enterprise Software Components][pe
components].

    $ eval "$(crossfader --ruby 1.9.3-p484 --gemset netdev shellinit)"

Once initialized, verify the environment is using the specified version of ruby
with the `gem env` command.

    $ gem env
    RubyGems Environment:
      - RUBYGEMS VERSION: 1.8.23
      - RUBY VERSION: 1.9.3 (2013-11-22 patchlevel 484) [x86_64-darwin13.0.0]
      - INSTALLATION DIRECTORY: /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/netdev/ruby/1.9.1
      - RUBY EXECUTABLE: /opt/crossfader/versions/ruby/1.9.3-p484/bin/ruby
      - EXECUTABLE DIRECTORY: /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/netdev/ruby/1.9.1/bin
      - RUBYGEMS PLATFORMS:
        - ruby
        - x86_64-darwin-13
      - GEM PATHS:
         - /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/netdev/ruby/1.9.1
         - /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/global/ruby/1.9.1
         - /opt/crossfader/versions/ruby/1.9.3-p484/lib/ruby/gems/1.9.1
         - /Users/jeff/.gem/ruby/1.9.1
      - GEM CONFIGURATION:
         - :update_sources => true
         - :verbose => true
         - :benchmark => false
         - :backtrace => false
         - :bulk_threshold => 1000
      - REMOTE SOURCES:
         - http://rubygems.org/

## Clone the Repository

Clone this repository into your local development workspace.

    $ git clone https://github.com/puppetlabs/netdev_stdlib
    Cloning into 'netdev_stdlib'...
    remote: Counting objects: 595, done.
    remote: Compressing objects: 100% (172/172), done.
    remote: Total 595 (delta 264), reused 587 (delta 261)
    Receiving objects: 100% (595/595), 76.83 KiB | 0 bytes/s, done.
    Resolving deltas: 100% (264/264), done.
    Checking connectivity... done.

## Install dependencies

The types depend primarily on Puppet which itself has a set of dependencies.
All of these additional software components should be installed using bundler
when developing the types and providers.

    $ cd netdev_stdlib/
    $ bundle install --path .bundle/gems/
    Fetching gem metadata from https://rubygems.org/.........
    Resolving dependencies...
    Installing rake (10.1.1)
    Installing CFPropertyList (2.2.8)
    Installing ast (2.0.0)
    Installing slop (3.6.0)
    Installing parser (2.2.0.pre.4)
    Installing astrolabe (1.3.0)
    Installing timers (1.1.0)
    Installing celluloid (0.15.2)
    Installing coderay (1.1.0)
    Installing diff-lcs (1.2.5)
    Installing docile (1.1.5)
    Installing facter (2.2.0)
    Installing ffi (1.9.3)
    Installing formatador (0.2.5)
    Installing rb-fsevent (0.9.4)
    Installing rb-inotify (0.9.5)
    Installing listen (2.7.9)
    Installing lumberjack (1.0.9)
    Installing method_source (0.8.2)
    Installing pry (0.10.1)
    Installing thor (0.19.1)
    Installing guard (2.6.1)
    Installing rspec-core (2.13.1)
    Installing rspec-expectations (2.13.0)
    Installing rspec-mocks (2.13.1)
    Installing rspec (2.13.0)
    Installing guard-rspec (3.1.0)
    Installing powerpack (0.0.9)
    Installing rainbow (2.0.0)
    Installing ruby-progressbar (1.5.1)
    Installing rubocop (0.26.0)
    Installing guard-rubocop (1.1.0)
    Installing json_pure (1.8.1)
    Installing hiera (1.3.4)
    Installing metaclass (0.0.4)
    Installing mocha (1.1.0)
    Installing multi_json (1.10.1)
    Installing yard (0.8.7.4)
    Installing pry-doc (0.6.0)
    Installing rgen (0.6.6)
    Installing puppet (3.6.2)
    Installing puppet-lint (1.0.1)
    Installing puppet-syntax (1.3.0)
    Installing rspec-puppet (1.0.1)
    Installing puppetlabs_spec_helper (0.8.1)
    Installing simplecov-html (0.8.0)
    Installing simplecov (0.9.0)
    Using bundler (1.3.6)
    Your bundle is complete!
    It was installed into ./.bundle/gems
    bundle install --path .bundle/gems/  7.74s user 1.99s system 45% cpu 21.569 total

## Run the spec tests

Before starting development of the types or providers, make sure the current
branch is known-good by automatically validating expected behavior against
actual behavior.

    $ bundle exec rspec spec/
    .........................................
    Finished in 2.43 seconds
    1213 examples, 0 failures
    Coverage report generated for Unit Tests to /netdev_stdlib/coverage/. 512 / 519 LOC (98.65%) covered.
    bundle exec rspec spec  3.59s user 0.27s system 99% cpu 3.896 total

## Test Driven Development

If the types are being changed, the spec tests may be automatically run in
response to file system change events using guard.

    $ bundle exec guard
    16:52:13 - INFO - Guard is using Tmux to send notifications.
    16:52:13 - INFO - Guard is using TerminalTitle to send notifications.
    16:52:13 - INFO - Guard::RSpec is running
    16:52:13 - INFO - Inspecting Ruby code style of all files
    16:52:16 - INFO - Guard is now watching at '/netdev_stdlib'
    [1] guard(main)>

# Implementing a provider

For a platform named `foo`, the following section describes how to implement a
module containing providers for the `netdev_stdlib` types.

The basic process for implementing providers for these types are as follows.
First, create a parent directory for use as the module directory.  This parent
directory will contain the `netdev_stdlib` module and the `netdev_stdlib_foo`
module.  For example, `/workspace/netdev/`.

Clone the `netdev_stdlib` into the module directory, for example
`/workspace/netdev/netdev_stdlib` and install dependencies using bundler as
described in Getting Started for Development.

## Generate the Provider Module

With a current working directory of the type module, generate the provider
module using `puppet module generate`:

    $ cd /workspace/netdev/netdev_stdlib/
    $ bundle exec puppet module generate acme-netdev_stdlib_foo
    We need to create a metadata.json file for this module.  Please answer the
    following questions; if the question is not applicable to this module, feel free
    to leave it blank.

    Puppet uses Semantic Versioning (semver.org) to version modules.
    What version is this module?  [0.1.0]
    --> 0.1.0

    Who wrote this module?  [acme]
    --> acme

    What license does this module code fall under?  [Apache 2.0]
    -->

    How would you describe this module in a single sentence?
    --> Acme Foo platform providers for the Network Device Standard Library types

    Where is this module's source code repository?
    --> https://github.com/acme/netdev_stdlib_foo

    Where can others go to learn more about this module?  [https://github.com/acme/netdev_stdlib_foo]
    -->

    Where can others go to file issues about this module?  [https://github.com/acme/netdev_stdlib_foo/issues]
    -->

    ----------------------------------------
    {
      "name": "acme-netdev_stdlib_foo",
      "version": "0.1.0",
      "author": "acme",
      "summary": "Acme Foo platform providers for the Network Device Standard Library types",
      "license": "Apache 2.0",
      "source": "https://github.com/acme/netdev_stdlib_foo",
      "project_page": "https://github.com/acme/netdev_stdlib_foo",
      "issues_url": "https://github.com/acme/netdev_stdlib_foo/issues",
      "dependencies": [
        {
          "name": "puppetlabs-stdlib",
          "version_range": ">= 1.0.0"
        }
      ]
    }
    ----------------------------------------

    About to generate this metadata; continue? [n/Y]

    Notice: Generating module at /workspace/serious/src/modules/netdev/test/netdev_stdlib/acme-netdev_stdlib_foo...
    Notice: Populating ERB templates...
    Finished; module generated in acme-netdev_stdlib_foo.
    acme-netdev_stdlib_foo/manifests
    acme-netdev_stdlib_foo/manifests/init.pp
    acme-netdev_stdlib_foo/metadata.json
    acme-netdev_stdlib_foo/Rakefile
    acme-netdev_stdlib_foo/README.md
    acme-netdev_stdlib_foo/spec
    acme-netdev_stdlib_foo/spec/classes
    acme-netdev_stdlib_foo/spec/classes/init_spec.rb
    acme-netdev_stdlib_foo/spec/spec_helper.rb
    acme-netdev_stdlib_foo/tests
    acme-netdev_stdlib_foo/tests/init.pp

Move the skeleton into the module directory:

    $ mv acme-netdev_stdlib_foo ../netdev_stdlib_foo
    $ cd ../netdev_stdlib_foo

## Express the dependencies

The provider module has the same dependencies as the type module and so it is
easiest to simply copy the dependency information from the `netdev_stdlib`
type.

    $ cp ../netdev_stdlib/{Gem,Guard}file .

Install the dependencies:

    $ bundle install --path .bundle/gems/

## Configure RSpec

Puppet Providers are generally tested with RSpec.  Copy the spec helper, which
initializes RSpec for module testing.

    $ cp ../netdev_stdlib/spec/spec_helper.rb spec/

Remove the rspec-puppet generated example for a puppet class.

    $ rm ./spec/classes/init_spec.rb

Test that rspec runs:

    $ bundle exec rspec spec/
    No examples found.
    Finished in 0.00004 seconds
    0 examples, 0 failures

## Mocking

The device API used by the provider should be modeled as a utility class in
`PuppetX::NetDev::FooApi` class, located at `lib/puppet_x/net_dev/foo_api.rb`.
Instance methods of this API class are suitable for mocking network based API
calls in the spec tests.  For REST API's the response data from the resource
request should be serialized into a fixtures directory.  These fixtures are
therefore able to be updated as API responses are changed or added over time.

For more information on rspec, please see https://github.com/rspec/rspec

# License

Copyright 2014-2018 [Puppet, Inc.][puppet]

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License.  You may obtain a copy of the
License at

[http://www.apache.org/licenses/LICENSE-2.0][license]

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied.  See the License for the
specific language governing permissions and limitations under the License.

[book]: http://shop.oreilly.com/product/0636920026860.do
[license]: http://www.apache.org/licenses/LICENSE-2.0
[travis]: https://travis-ci.org/puppetlabs/netdev_stdlib/builds
[puppet]: https://puppet.com
[types doc]: https://docs.puppetlabs.com/guides/custom_types.html
[gary provider]: http://garylarizza.com/blog/2013/12/15/seriously-what-is-this-provider-doing/
[crossfader]: http://github.com/puppetlabs/crossfader
[crossfader quick start]: https://github.com/puppetlabs/crossfader#quick-start-install
[rvm]: http://rvm.io/
[rbenv]: https://github.com/sstephenson/rbenv
[pe components]: https://docs.puppetlabs.com/pe/latest/install_what_and_where.html#puppet-enterprise-software-components
[buildstatus]: https://travis-ci.org/puppetlabs/netdev_stdlib.svg?branch=master
