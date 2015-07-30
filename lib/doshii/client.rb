require 'doshii/client/checkin'
require 'doshii/client/location'
require 'doshii/client/order'
require 'doshii/client/product'
require 'doshii/client/table'
require 'doshii/connection'
require 'doshii/exceptions'
require 'doshii/resource'

module Doshii
  class << self
    def checkin
      resource 'checkins'
    end

    def location
      resource 'locations'
    end

    def order
      resource 'orders'
    end

    def product
      resource 'products'
    end

    def table
      resource 'tables'
    end

    def options
      Hash[*Configuration::VALID_CONFIG_KEYS.map { |key| [key, value(key)] }.flatten]
    end

    def resource(url)
      Doshii::Resource.new url, options
    end

    def value(key)
      key = "@#{key.to_s}".to_sym
      Doshii.instance_variable_get(key)
    end
  end

  class Client
    include Connection
    include Checkin
    include Location
    include Order
    include Product
    include Table

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})
      merged_options = Doshii.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
      raise Doshii::ConfigurationError.new('client_id and client_secret are required') if invalid_config?
    end

    private

    def invalid_config?
      @client_id.nil? || @client_id.empty? || @client_secret.nil? || @client_secret.empty?
    end
  end
end
