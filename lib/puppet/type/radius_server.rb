# encoding: utf-8

Puppet::Type.newtype(:radius_server) do
  @doc = 'Configure a radius server'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the radius server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:hostname) do
    desc 'The hostname or address of the radius server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:auth_port) do
    desc 'Port number to use for authentication'
    munge { |v| Integer(v) }
  end

  newproperty(:acct_port) do
    desc 'Port number to use for accounting'
    munge { |v| Integer(v) }
  end

  newproperty(:key) do
    desc 'Encryption key (plaintext or in hash form depending on key_format)'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:key_format) do
    desc 'Encryption key format [0-7]'
    munge { |v| Integer(v) }
  end

  newproperty(:group) do
    desc 'Server group associated with this server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:deadtime) do
    desc 'Number of minutes to ignore an unresponsive server'
    munge { |v| Integer(v) }
  end

  newproperty(:timeout) do
    desc 'Number of seconds before the timeout period ends'
    munge { |v| Integer(v) }
  end

  newproperty(:vrf) do
    desc 'Interface to send syslog data from, e.g. "management"'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:source_interface) do
    desc 'Source interface to send syslog data from, e.g. "ethernet 2/1"'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:retransmit_count) do
    desc 'How many times to retransmit'
    munge { |v| Integer(v) }
  end

  newproperty(:accounting_only) do
    desc 'Enable this server for accounting only'
    newvalues(:true, :false)
  end

  newproperty(:authentication_only) do
    desc 'Enable this server for authentication only'
    newvalues(:true, :false)
  end
end
