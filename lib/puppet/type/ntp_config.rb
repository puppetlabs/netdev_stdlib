# encoding: utf-8

Puppet::Type.newtype(:ntp_config) do
  @doc = 'Global configuration for the NTP system'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'Resource name, not used to configure the device'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:authenticate) do
    desc 'NTP authentication enabled [true|false]'
    newvalues(:true, :false)
  end

  newproperty(:source_interface) do
    desc 'The source interface for the NTP system'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:trusted_key, array_matching: :all) do
    desc 'Array of global trusted-keys.  Contents can be a String or Integers'

    validate do |value|
      if (value.is_a? String) || (value.is_a? Integer) then super(value)
      else fail "value #{value.inspect} is invalid, must be a String or Integer."
      end
    end

    def insync?(is)
      is.map(&:to_s).sort == @should.map(&:to_s).sort
    end

    def should_to_s(new_value=@should)
      self.class.format_value_for_display(new_value)
    end

    def is_to_s(current_value=@is)
      self.class.format_value_for_display(current_value)
    end
  end
end
