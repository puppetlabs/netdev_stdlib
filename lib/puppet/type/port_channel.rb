require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:port_channel) do
    @doc = 'Network Device Link Aggregation Group'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'LAG Name'

      validate do |value|
        case value
        when String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newparam(:force) do
      desc 'Force configuration (true / false)'
      newvalues(:true, :false)
    end

    newproperty(:id) do
      desc 'Channel Group ID, e.g. 10'
      munge { |v| Integer(v) }
    end

    newproperty(:description) do
      desc 'Port Channel description'

      validate do |value|
        if value.is_a? String
          super(value)
          validate_features_per_value(value)
        else raise "value #{value.inspect} is invalid, must be a string."
        end
      end
    end

    newproperty(:mode) do
      desc 'LACP mode [ passive | active | disabled* ]'
      newvalues(:active, :passive, :disabled)
    end

    newproperty(:interfaces, array_matching: :all) do
      desc 'Array of Physical Interfaces'

      validate do |val|
        raise "value #{val.inspect} must be a string" unless val.is_a? String
        raise "value #{val.inspect} has no digits" unless /\d+/.match(val) # rubocop:disable Performance/RedundantMatch
      end

      def insync?(is)
        is.sort == @should.sort.map(&:to_s)
      end
    end

    newproperty(:minimum_links) do
      desc 'Number of active links required for LAG to be up'
      munge { |v| Integer(v) }
    end

    newproperty(:speed) do
      desc 'Link speed [auto*|10m|100m|1g|10g|40g|56g|100g]'
      newvalues(:auto, '1g', '10g', '40g', '56g', '100g', '100m', '10m')
    end

    newproperty(:duplex) do
      desc 'Duplex mode [auto*|full|half]'
      newvalues(:auto, :full, :half)
    end

    newproperty(:flowcontrol_send) do
      desc 'Flow control (send) [desired|on|off]'
      newvalues(:desired, :on, :off)
    end

    newproperty(:flowcontrol_receive) do
      desc 'Flow control (receive) [desired|on|off]'
      newvalues(:desired, :on, :off)
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'port_channel',
    docs: 'Network Device Link Aggregation Group',
    features: ['canonicalize','simple_get_filter'] + ( Puppet::Util::NetworkDevice.current.nil? ? [] : ['remote_resource'] ),
    attributes: {
      ensure: {
        type:    'Enum[present, absent]',
        desc:    'Whether this port channel should be enabled on the target system.',
      },
      name: {
        type:   'String',
        desc:   'LAG Name',
        behaviour: :namevar
      },
      force: {
        type:   'Optional[Boolean]',
        desc:   'Force configuration (true / false)'
      },
      id: {
        type:   'Optional[Integer]',
        desc:   'Channel Group ID, e.g. 10'
      },
      description: {
        type:   'Optional[String]',
        desc:   'Port Channel description'
      },
      mode: {
        type:    'Optional[Enum["active","passive", "disabled"]]',
        desc:    'LACP mode [ passive | active | disabled* ]'
      },
      interfaces: {
        type:    'Optional[Array[String]]',
        desc:    'Array of Physical Interfaces'
      },
      minimum_links: {
        type:   'Optional[Integer]',
        desc:   'Number of active links required for LAG to be up'
      },
      speed: {
        type:    'Optional[Enum["auto","10m","100m","1g","10g","40g","56g","100g"]]',
        desc:    'Link speed [auto*|10m|100m|1g|10g|40g|56g|100g]'
      },
      duplex: {
        type:    'Optional[Enum["auto","full","half"]]',
        desc:    'Duplex mode [auto*|full|half]'
      },
      flowcontrol_send: {
        type:   'Optional[Enum["desired","on","off"]]',
        desc:   'Flow control (send) [desired|on|off]'
      },
      flowcontrol_receive: {
        type:   'Optional[Enum["desired","on","off"]]',
        desc:   'Flow control (receive) [desired|on|off]'
      }
    }
  )
end
