require 'doshii/resource'

module Doshii
  class << self
    def checkin
      resource 'checkins'
    end

    def location
      resource 'locations'
    end

    def product
      resource 'products'
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
end
