Puppet::Type.newtype(:port_channel) do
  @doc = 'Network Device Link Aggregation Group'

  ensurable

  newparam(:name, namevar: true) do
    desc "LAG Name"

    validate do |value|
      case value
      when String then super(value)
      else self.fail "value #{value.inspect} is invalid, must be a String."
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
      if String === value
        super(value)
        validate_features_per_value(value)
      else
        self.fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  newproperty(:mode) do
    desc 'LACP mode [ passive | active | disabled* ]'
    newvalues(:active, :passive, :disabled)
  end

  newproperty(:minimum_links) do
    desc 'Number of active links required for LAG to be up'
    munge { |v| Integer(v) }
  end

  newproperty(:interfaces, :array_matching => :all) do
    desc 'Array of Physical Interfaces'

    validate do |val|
      if not String === val
        self.fail "value #{val.inspect} must be a string"
      end
      if not /\d+/.match(val)
        self.fail "value #{val.inspect} does not contain any digits"
      end
    end

    def insync?(is)
      is.sort == @should.sort.map(&:to_s)
    end
  end

  newproperty(:speed) do
    desc "Link speed [auto*|10m|100m|1g|10g|40g|56g|100g]"
    newvalues(:auto,"1g","10g","40g","56g","100g","100m","10m")
  end

  newproperty(:duplex) do
    desc "Duplex mode [auto*|full|half]"
    newvalues(:auto, :full, :half)
  end

  newproperty(:flowcontrol_send) do
    desc "Flow control (send) [desired|on|off]"
    newvalues(:desired, :on, :off)
  end
  newproperty(:flowcontrol_receive) do
    desc "Flow control (receive) [desired|on|off]"
    newvalues(:desired, :on, :off)
  end
end
