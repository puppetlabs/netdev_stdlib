# encoding: utf-8

Puppet::Type.newtype(:domain_name) do
  @doc = 'Configure the domain name of the device'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The domain name of the device'

    validate do |value|
      if value.is_a? String then super(value)
      else fail "value #{value.inspect} is invalid, must be a String."
      end
    end
  end
end
