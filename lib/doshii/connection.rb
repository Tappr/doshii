require 'base64'
require 'faraday'
require 'faraday_middleware'

module Doshii
  module Connection
    protected

    def get(url, query = {})
      request :get, url, query
    end

    def post(url, query = {}, &body_block)
      body = Hash.new
      yield body if block_given?
      request :post, url, query, body
    end

    def put(url, body = {})
      request :put, url, body
    end

    def delete(url)
      request :delete, url
    end

    def http_connection
      @http_connection ||=
        Faraday.new("#{endpoint}/#{version}/") do |faraday|
          faraday.response :logger
          faraday.adapter  Faraday.default_adapter
          faraday.use      Faraday::Response::ParseJson

          faraday.headers['Authorization'] = "Basic #{base64_encoded_key}"
          faraday.headers['Content-Type']  = 'application/json'
          faraday.ssl['verify']            = verify_ssl
        end
    end

    def request(method, url, query = {}, body = {})
      http_connection.send(method) do |req|
        req.url url, query
        req.body = JSON.generate(body)
      end
    end

    private

    def base64_encoded_key
      key = "#{client_id}:#{client_secret}"
      Base64.urlsafe_encode64 key
    end
  end
end
