# Change log
All notable changes to this project will be documented in this file.

## 0.16.0 - 2018-09-13
### Summary:
This release adds syslog_facility type, enhances network_dns and syslog_settings

### Added:
- `network_dns`
  - hostname
- `syslog_facility` type
  - level
- `syslog_settings`
  - logfile_severity_level
  - logfile_name
  - logfile_size
  - buffered_severity_level
  - buffered_size

### Fixed:
- `banner` ensure value is String

## 0.15.0 - 2018-08-06
### Summary:
This release adds banner type, enhances syslog, and deprecates domain_name, name_server, search_domain

### Added:
- `banner` type
  - motd
- `syslog_server`
  - facility
- `syslog_settings`
  - facility

### Deprecated:
- `domain_name` replaced by `network_dns`
- `name_server` replaced by `network_dns`
- `search_domain` replaced by `network_dns`

## 0.14.1 - 2018-06-19
### Summary:
This is a bugfix release

### Fixed:
- `port_channel` removed invalid default value
- `snmp_notification_receiver` add `v2c` version

## 0.14.0 - 2018-06-05
### Summary:
This release adds [Resource API](https://github.com/puppetlabs/puppet-resource_api) versions of the types.

Both versions of the types perform the same in the catalog, but stricter type checking is enabled with RSAPI versions.

Only one version can be loaded into an environment at a time.  On the master, RSAPI version of the types will always be loaded when Resource API gem is present.  This will be the default behavior in future versions of Puppet.

On the agent, legacy types will be loaded if the operatingsystem is `aristaeos, ios_xr, or nexus`, otherwise RSAPI version is loaded.

### Added:
- Resource API version of all types

### Fixed:
- `network_trunk` range of of `untagged_vlan` now 0-4095

## 0.13.0 - 2017-11-13
### Summary:
This release enhances syslog, RADIUS, TACACS, and SNMP types

### Added:
- `syslog_server`
  - port
- `syslog_settings`
  - console
  - monitor
  - source_interface
  - vrf
- `radius_global`
  - source_interface
  - vrf
- `tacacs_global`
  - source_interface
  - vrf

### Fixed:
- `snmp_user` version parameter changed to property

## 0.12.0 - 2017-05-03
### Summary:
This release enhances NTP types

### Added:
- `ntp_auth_key` type
  - algorithm
  - mode
  - password
- `ntp_config` type
  - authenticate
  - trusted_key
- `ntp_server` type
  - key
  - maxpoll
  - minpoll
  - source_interface
  - vrf

## 0.11.1 - 2016-02-11
### Summary:
This release changes `snmp_notification_receiver` type's `port` and `username` parameters to properties so they may be managed directly.

### Fixed:
- `snmp_notification_receiver` port parameter changed to property
- `snmp_notification_receiver` username parameter changed to property
- `snmp_user` version parameter now specified as not a namevar

## 0.11.0 - 2015-11-05
### Summary:
This backwards-incompatible release adds several useful types and type properties, makes several types not have conflicting namevars, removes several unuseful types, and fixes some discrepancies.

### Changed:
- Removed `snmp_contact` type
- Removed `snmp_location` type
- Removed `snmp_protocol` type
- (NETDEV-20) Change `snmp_notification_receiver` namevar to host:port:username
  (see a3aabdd)
- (NETDEV-22) Change `snmp_user` namevar to name:version (see 06302ac)

### Added:
- `network_dns` type
- `network_snmp` type
- `radius_server` hostname property
- `radius_global` enable property
- `tacacs_global` enable property
- `tacacs_server` hostname, vrf, and port properties
- `snmp_user` version property
- Ability for types to work either for normal or device resources


### Fixed:
- `ntp_server` is ensurable so that it may be ensure present or absent
- `radius_server` is ensurable so that it may be ensure present or absent
- `snmp_community` is ensurable so that it may be ensure present or absent
- `tacacs_server` is ensurable so that it may be ensure present or absent
- `tacacs_server_group` is ensurable so that it may be ensure present or absent
- `tacacs_server_group` array value output formatting
- `radius_server_group` array value output formatting
- `snmp_user` array value output formatting

## 0.10.0 - 2014-09-09
### Summary:
This is the initial release of the netdev\_stdlib to the forge.
