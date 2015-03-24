# encoding: utf-8

Puppet::Type.newtype(:tacacs_global) do
  @doc = 'Configure global tacacs settings'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'Resource identifier, not used to manage the device'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:enable) do
    desc 'Enable or disable radius functionality [true|false]'
    newvalues(:true, :false)
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

  newproperty(:retransmit_count) do
    desc 'How many times to retransmit'
    munge { |v| Integer(v) }
  end
end
