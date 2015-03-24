# encoding: utf-8

Puppet::Type.newtype(:network_interface) do
  @doc = 'Manage physical network interfaces, e.g. Ethernet1'

  apply_to_all

  newproperty(:enable) do
    desc 'Enable the interface, true or false'
    newvalues(:true, :false)
  end

  # Parameters (additional data)

  newparam(:name, namevar: true) do
    desc 'Interface Name, e.g. Ethernet1'

    validate do |value|
      case value
      when String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  # Properties (state)

  newproperty(:description) do
    desc 'Interface physical port description'

    validate do |value|
      case value
      when String
        super(value)
        validate_features_per_value(value)
      else fail "value #{value.inspect} is invalid, must be a string."
      end
    end
  end

  newproperty(:mtu) do
    desc 'Interface Maximum Transmission Unit in bytes'
    munge { |v| Integer(v) }
    validate do |v|
      begin
        Integer(v) ? true : false
      rescue TypeError => err
        error "Cannot convert #{v.inspect} to an integer: #{err.message}"
      end
    end
  end

  newproperty(:speed) do
    desc 'Link speed [auto*|10m|100m|1g|10g|40g|56g|100g]'
    newvalues(:auto, '1g', '10g', '40g', '56g', '100g', '100m', '10m')
  end

  newproperty(:duplex) do
    desc 'Duplex mode [auto*|full|half]'
    newvalues(:auto, :full, :half)
  end
end
