module Doshii
  module Configuration
    VALID_CONNECTION_KEYS = [:subdomain, :verify_ssl, :version].freeze
    VALID_OPTIONS_KEYS    = [:client_id, :client_secret].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_SUBDOMAIN     = 'alphasandbox'
    DEFAULT_VERIFY_SSL    = false
    DEFAULT_VERSION       = 'v1'

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      @subdomain     = DEFAULT_SUBDOMAIN
      @verify_ssl    = DEFAULT_VERIFY_SSL
      @version       = DEFAULT_VERSION
    end

    def configure
      yield self
    end

    def options
      Hash[*VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten]
    end
  end
end
