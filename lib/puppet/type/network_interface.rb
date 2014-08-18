Puppet::Type.newtype(:network_interface) do
  @doc = "Manage network interfaces, e.g. Ethernet1"

  newproperty(:enable) do
    desc "Enable the interface, true or false"
    newvalues(:true, :false)
  end

  # Parameters (additional data)

  newparam(:name, :namevar => true) do
    desc "Interface Name, e.g. Ethernet1"

    validate do |value|
      case value
      when String
        super(value)
      else
        self.fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  # Properties (state)

  newproperty(:description) do
    desc "Interface physical port description"

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

  newproperty(:mtu) do
    desc "Interface Maximum Transmission Unit in bytes"
    munge { |v| Integer(v) }
    validate do |v|
      begin
        !! Integer(v)
      rescue TypeError => err
        self.error "Cannot convert #{v.inspect} to an integer: #{err.message}"
      end
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

  newproperty(:trunk_encapsulation) do
    desc "Trunk encapsulation mode [none*|isl|dot1q|negotiate]"
    newvalues(:none, :isl, :dot1q, :negotiate)
  end

  newproperty(:mode) do
    desc "Interface mode [access*|dynamic_auto|dynamic_desirable|trunk]"
    newvalues(:access, :dynamic_auto, :dynamic_desirable, :trunk)
  end

  newproperty(:access_vlan) do
    desc "Access mode VLAN ID, e.g. 100"
    munge { |v| Integer(v) }
    validate do |v|
      begin
        !! Integer(v)
      rescue TypeError => err
        self.error "Cannot convert #{v.inspect} to an integer: #{err.message}"
      end
    end
  end

  newproperty(:trunk_native_vlan) do
    desc "Trunk mode native VLAN ID, e.g. 200"
    munge { |v| Integer(v) }
    validate do |v|
      begin
        !! Integer(v)
      rescue TypeError => err
        self.error "Cannot convert #{v.inspect} to an integer: #{err.message}"
      end
    end
  end

  newproperty(:trunk_allowed_vlan) do
    desc <<-EOT
      Trunk mode allowed range(s) of VLAN ID's, e.g. '200..300' or
      ['200..300', '400..500']
    EOT

    munge do |v|
      case v
      when String
        re = %r{\s*,\s*}
        if re.match(v)
          items = v.split(re)
        else
          items = [v]
        end

        items.collect do |element|
          re = %r{\s*\.\.\s*|\s*-\s*}
          if re.match(element)
            args = element.split(re).map {|s| Integer(s) }
            Range.new(*args)
          else
            Range.new(Integer(element), Integer(v))
          end
        end
      end
    end

    validate do |v|
      case v
      when String
        true
      else
        self.error "#{v.inspect} is invalid, must be a string"
      end
    end
  end

  newproperty(:trunk_pruning_vlan) do
    desc <<-EOT
      Trunk pruning allowed range(s) of VLAN ID's, e.g. '200..300' or
      ['200..300', '400..500']
    EOT

    munge do |v|
      case v
      when String
        re = %r{\s*,\s*}
        if re.match(v)
          items = v.split(re)
        else
          items = [v]
        end

        items.collect do |element|
          re = %r{\s*\.\.\s*|\s*-\s*}
          if re.match(element)
            args = element.split(re).map {|s| Integer(s) }
            Range.new(*args)
          else
            Range.new(Integer(element), Integer(v))
          end
        end
      end
    end

    validate do |v|
      case v
      when String
        true
      else
        self.error "#{v.inspect} is invalid, must be a string"
      end
    end
  end
end
