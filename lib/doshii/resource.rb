require 'doshii/connection'
require 'doshii/response'

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
      process_response(request :get, @url)
    end

    def create(id = nil, query = {}, &block)
      url = id.nil? ? @url : "#{@url}/#{id}"
      process_response(request :post, url, query, &block)
    end

    def delete(id)
      process_response(request :delete, "#{@url}/#{id}")
    end

    def find(id)
      process_response(request :get, "#{@url}/#{id}")
    end

    def update(id, query = {}, &block)
      process_response(request :put, "#{@url}/#{id}", query, &block)
    end

    private

    def process_response(res)
      return res if (res.status != 200 && res.body.blank?) || res.status == 404
      return res.body.collect { |r| Doshii::Response[r] } if res.body.is_a? Array
      body = Doshii::Response[res.body]
    end
  end
end
