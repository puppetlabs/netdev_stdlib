# encoding: utf-8

Puppet::Type.newtype(:snmp_notification) do
  @doc = 'Enable or disable notification groups and events'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'The notification name or "all" for all notifications'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end

  newproperty(:enable) do
    desc 'Enable or disable the notification [true|false]'
    newvalues(:true, :false)
  end
end
