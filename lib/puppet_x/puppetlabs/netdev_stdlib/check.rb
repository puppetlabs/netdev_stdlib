require 'puppet_x'
module PuppetX::NetdevStdlib
  # Helper function to check if we should load the resource_api
  class Check
    def self.use_old_netdev_type
      # check if Resource API is available
      begin
        require 'puppet/resource_api'
        use_old_netdev = false
      rescue LoadError
        return true
      end
      # is this an agent running on a network device do no use RSAPI - there are only a few of them
      use_old_netdev = %w[aristaeos ios_xr].include? Facter.value('operatingsystem').downcase
      use_old_netdev
    end
  end
end
