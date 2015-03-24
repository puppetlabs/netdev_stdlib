# encoding: utf-8

Puppet::Type.newtype(:radius_server_group) do
  @doc = 'Configure a radius server group'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the radius server group'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:servers, array_matching: :all) do
    desc 'Array of servers associated with this group'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end

    def should_to_s(new_value=@should)
      self.class.format_value_for_display(new_value)
    end

    def is_to_s(current_value=@is)
      self.class.format_value_for_display(current_value)
    end
  end
end
