module Puppet; end # rubocop:disable Style/Documentation
module Puppet::ResourceApi

  class Puppet::Provider::NetdevBaseProvider
    def initialize
      name_components = self.class.name.split('::')
      class_name = name_components[-2]
      @device_provider = if Facter.value('operatingsystem').downcase == 'nexus'
                            Puppet::Provider.const_get(class_name, false).const_get("CiscoNexus", false).new
                         else
                            raise Puppet::ResourceError, "the #{class_name} resource is not supported to run on #{Facter.value('operatingsystem')}"
                         end
    end

    extend Forwardable
    attr_reader :device_provider

    def_delegators :device_provider, :get, :set, :canonicalize
  end
end
