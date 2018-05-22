module PuppetX
  module PuppetLabs
    module NetdevStdlib
      module Property
        class PortRange < Puppet::Property
          validate do |value|
            raise "value #{value.inspect} is invalid, must be 1-65535." unless
            value.to_i.between?(1, 65_535)
            super(value)
          end
        end
      end
    end
  end
end
