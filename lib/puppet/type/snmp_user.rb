require_relative '../../puppet_x/puppetlabs/netdev_stdlib/check'
if PuppetX::NetdevStdlib::Check.use_old_netdev_type
  Puppet::Type.newtype(:snmp_user) do
    @doc = 'Set the SNMP contact name'

    apply_to_all
    ensurable

    newparam(:name, namevar: true) do
      desc 'The name of the SNMP user'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:version) do
      desc 'SNMP version [v1|v2|v2c|v3]'

      newvalues(:v1, :v2, :v2c, :v3)
    end

    newproperty(:roles, array_matching: :all) do
      desc 'A list of roles associated with this SNMP user'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end

      def should_to_s(new_value = @should)
        self.class.format_value_for_display(new_value)
      end

      def is_to_s(current_value = @is)
        self.class.format_value_for_display(current_value)
      end
    end

    newproperty(:auth) do
      desc 'Authentication mode [md5|sha]'
      newvalues(:md5, :sha)
    end

    newproperty(:password) do
      desc 'Cleartext password for the user'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newproperty(:privacy) do
      desc 'Privacy encryption method [aes128|des]'
      newvalues(:aes128, :des)
    end

    newproperty(:private_key) do
      desc 'Private key in hexadecimal string'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    newparam(:localized_key) do
      desc 'If true, password needs to be a hexadecimal value'
      newvalues(:true, :false)
    end

    newparam(:enforce_privacy) do
      desc 'If true, message encryption is enforced'
      newvalues(:true, :false)
    end

    newproperty(:engine_id) do
      desc 'Necessary if the SNMP engine is encrypting data'

      validate do |value|
        if value.is_a? String then super(value)
        else raise "value #{value.inspect} is invalid, must be a String."
        end
      end
    end

    def self.title_patterns
      identity = nil # optimization in Puppet core
      name = [:name, identity]
      version = [:version, ->(x) { x.to_sym }]
      [
        [/^([^:]*)$/,                 [name]],
        [/^([^:]*):([^:]*)$/,         [name, version]]
      ]
    end
  end
else
  require 'puppet/resource_api'

  Puppet::ResourceApi.register_type(
    name: 'snmp_user',
    docs: 'Set the SNMP contact name',
    features: ['remote_resource'],
    attributes: {
      ensure: {
        type:       'Enum[present, absent]',
        desc:       'Whether the SNMP User should be present or absent on the target system.',
        default:    'present'
      },
      # TODO: NETDEV-36: composite namevars
      name: {
        type:       'String',
        desc:       'Composite ID of username / version (if applicable)',
        behaviour:  :namevar
      },
      version: {
        type:      'Optional[Enum["v1", "v2", "v2c", "v3"]]',
        desc:      'SNMP version [v1|v2|v2c|v3]'
      },
      roles: {
        type:       'Optional[Array[String]]',
        desc:       'A list of roles associated with this SNMP user'
      },
      auth: {
        type:      'Optional[Enum["md5", "sha"]]',
        desc:      'Authentication mode [md5|sha]'
      },
      password: {
        type:      'Optional[String]',
        desc:      'Cleartext password for the user'
      },
      privacy: {
        type:      'Optional[Enum["aes128", "aes192", "aes256", "des", "3des"]]',
        desc:      'Privacy encryption method [aes128|aes192|aes256|des|3des]'
      },
      private_key: {
        type:      'Optional[String]',
        desc:      'Private key in hexadecimal string'
      },
      localized_key: {
        type:      'Optional[Boolean]',
        desc:      'If true, password needs to be a hexadecimal value [true|false]'
      },
      enforce_privacy: {
        type:      'Optional[Boolean]',
        desc:      'If true, message encryption is enforced [true|false]'
      },
      engine_id: {
        type:      'Optional[String]',
        desc:      'Necessary if the SNMP engine is encrypting data'
      }
    }
  )
end
