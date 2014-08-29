# encoding: utf-8

Puppet::Type.newtype(:tacacs_server) do
  @doc = 'Configure a tacacs server'

  newparam(:name, namevar: true) do
    desc 'The name of the tacacs server group'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
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

  newproperty(:timeout) do
    desc 'Number of seconds before the timeout period ends'
    munge { |v| Integer(v) }
  end

  newproperty(:single_connection) do
    desc 'Enable or disable session multiplexing [true|false]'
    newvalues(:true, :false)
  end

  newproperty(:group) do
    desc 'Server group associated with this server'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
