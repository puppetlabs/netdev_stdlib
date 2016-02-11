# Change log
All notable changes to this project will be documented in this file.

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
