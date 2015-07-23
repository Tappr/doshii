require 'base64'
require 'doshii/exceptions'
require 'faraday'
require 'faraday_middleware'

module Doshii
  module Connection
    protected

    URL = "https://%{subdomain}.doshii.co/partner/api"

    def http_connection
      @http_connection ||=
        Faraday.new("#{URL % { subdomain: subdomain }}/#{version}/") do |faraday|
          faraday.response :logger
          faraday.adapter  Faraday.default_adapter
          faraday.use      Faraday::Response::ParseJson

          faraday.headers['Authorization'] = "Basic #{base64_encoded_key}"
          faraday.headers['Content-Type']  = 'application/json'
          faraday.ssl['verify']            = verify_ssl
        end
    end

    def request(method, url, query = {}, &block)
      body = Hash.new
      yield body if block_given?
      http_connection.send(method) do |req|
        req.url url, query
        req.body = JSON.generate(body)
      end
    rescue Exception => e
      raise Doshii::ConnectionError.new(e)
    end

    private

    def base64_encoded_key
      key = "#{client_id}:#{client_secret}"
      Base64.urlsafe_encode64 key
    end
  end
end
