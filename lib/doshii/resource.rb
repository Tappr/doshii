require 'doshii/connection'

module Doshii
  class Resource
    include Connection

    attr_writer   :url
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(url, options = {})
      @url = url
      merged_options = Doshii.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def all
      request :get, @url
    end

    def create(id = nil, query = {}, &block)
      url = id.nil? ? @url : "#{@url}/#{id}"
      request :post, url, query, &block
    end

    def delete(id)
      request :delete, "#{@url}/#{id}"
    end

    def find(id)
      request :get, "#{@url}/#{id}"
    end

    def update(id, query = {}, &block)
      request :put, "#{@url}/#{id}", query, &block
    end
  end
end
