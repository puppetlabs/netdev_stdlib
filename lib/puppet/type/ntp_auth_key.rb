# encoding: utf-8

require_relative '../../puppet_x/puppetlabs/netdev_stdlib/property/port_range'

Puppet::Type.newtype(:ntp_auth_key) do
  @doc = 'NTP Authentication keys'

  apply_to_all
  ensurable

  newparam(:name, namevar: true, parent: PuppetX::PuppetLabs::NetdevStdlib::Property::PortRange) do
    desc 'Authentication key ID'

    # Make sure we have a string, casting to int first also strips whitespace
    munge do |value|
      Integer(value).to_s
    end
  end

  newproperty(:algorithm) do
    desc 'Hash algorithm [md5|sha1|sha256]'

    newvalues(:md5, :sha1, :sha256)
  end

  newproperty(:mode) do
    desc 'Password mode [0 (plain) | 7 (encrypted)]'

    munge { |v| Integer(v) }
  end

  newproperty(:password) do
    desc 'Password text'

    validate do |value|
      fail "value #{value.inspect} is invalid, must be a String." unless
      value.is_a? String
      super(value)
    end
  end
end
