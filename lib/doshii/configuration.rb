module Doshii
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :verify_ssl, :version].freeze
    VALID_OPTIONS_KEYS    = [:client_id, :client_secret].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = 'https://alphasandbox.doshii.co/partner/api'
    DEFAULT_VERIFY_SSL    = false
    DEFAULT_VERSION       = 'v1'

    DEFAULT_CLIENT_ID     = '369c27e8d884e0b54e56035b41eed4b07b0fc59091907418f0368ab643a4ad31'
    DEFAULT_CLIENT_SECRET = 'c0c0441e9bcc671dff9beb8e2a16fb43ed392f8c9a029dc8075cb71b1ac87e5f'

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      @endpoint      = DEFAULT_ENDPOINT
      @verify_ssl    = DEFAULT_VERIFY_SSL
      @client_id     = DEFAULT_CLIENT_ID
      @client_secret = DEFAULT_CLIENT_SECRET
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
