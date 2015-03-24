# encoding: utf-8

Puppet::Type.newtype(:port_channel) do
  @doc = 'Network Device Link Aggregation Group'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'LAG Name'

    validate do |value|
      case value
      when String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newparam(:force) do
    desc 'Force configuration (true / false)'
    newvalues(:true, :false)
  end

  newproperty(:id) do
    desc 'Channel Group ID, e.g. 10'
    munge { |v| Integer(v) }
  end

  newproperty(:description) do
    desc 'Port Channel description'

    validate do |value|
      if value.is_a? String
        super(value)
        validate_features_per_value(value)
      else fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  newproperty(:mode) do
    desc 'LACP mode [ passive | active | disabled* ]'
    newvalues(:active, :passive, :disabled)
  end

  newproperty(:interfaces, array_matching: :all) do
    desc 'Array of Physical Interfaces'

    validate do |val|
      fail "value #{val.inspect} must be a string" unless val.is_a? String
      fail "value #{val.inspect} has no digits" unless /\d+/.match(val)
    end

    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end
  end

  newproperty(:minimum_links) do
    desc 'Number of active links required for LAG to be up'
    munge { |v| Integer(v) }
  end

  newproperty(:speed) do
    desc 'Link speed [auto*|10m|100m|1g|10g|40g|56g|100g]'
    newvalues(:auto, '1g', '10g', '40g', '56g', '100g', '100m', '10m')
  end

  newproperty(:duplex) do
    desc 'Duplex mode [auto*|full|half]'
    newvalues(:auto, :full, :half)
  end

  newproperty(:flowcontrol_send) do
    desc 'Flow control (send) [desired|on|off]'
    newvalues(:desired, :on, :off)
  end

  newproperty(:flowcontrol_receive) do
    desc 'Flow control (receive) [desired|on|off]'
    newvalues(:desired, :on, :off)
  end
end
