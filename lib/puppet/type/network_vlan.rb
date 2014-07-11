Puppet::Type.newtype(:network_vlan) do
  @doc = "Manage VLAN's.  Layer-2 VLAN's are managed by this resource type."

  ensurable

  # Parameters (additional data)

  newparam(:name, :namevar=>true) do
    desc <<-EOT
      The resource identifier.  The value does not affect the configuration and
      instead is used to identify this resource within Puppet and related
      tools.
    EOT

    validate do |value|
      case value
      when String
        super(value)
      else
        self.fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  # Properties (state management)

  newproperty(:description) do
    desc "The VLAN Description, e.g. 'Engineering'"

    validate do |value|
      case value
      when String
        super(value)
        validate_features_per_value(value)
      else
        self.fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  newproperty(:id) do
    desc "The VLAN ID, e.g. 100"

    munge do |value|
      case value
      when String
        value.to_i
      else
        value
      end
    end

    validate do |value|
      case value
      when Fixnum, "0"
        true
      when String
        if value.to_i == 0
          self.error "value #{value.inspect} is invalid, must be a number"
        end
      else
        self.error "value #{value.inspect} is invalid, must be a number"
      end
    end
  end

  newproperty(:shutdown) do
    desc "VLAN shutdown if true, not shutdown if false"

    munge do |value|
      case value
      when true, :true, "true"
        true
      when false, :false, "false"
        false
      end
    end

    validate do |value|
      case value
      when true, false, :true, :false, "true", "false"
        super(value)
        validate_features_per_value(value)
      else
        self.fail "value #{value.inspect} is invalid, must be true or false"
      end
    end
  end
end
