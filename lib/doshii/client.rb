require 'doshii/connection'
require 'doshii/client/checkin'
require 'doshii/client/location'
require 'doshii/client/order'
require 'doshii/client/product'

module Doshii
  class Client
    include Connection
    include Checkin
    include Location
    include Order
    include Product

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})
      merged_options = Doshii.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end
  end
end
