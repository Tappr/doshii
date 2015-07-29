require 'base64'
require 'doshii/exceptions'
require 'doshii/response'
require 'faraday'
require 'faraday_middleware'

module Doshii
  module Connection
    protected

    URL = "https://%{subdomain}.doshii.co/partner/api"

    def http_connection
      @http_connection ||=
        Faraday.new("#{URL % { subdomain: subdomain }}/#{version}/") do |faraday|
          # faraday.response :logger
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
      response = http_connection.send(method) do |req|
        req.url url, query
        req.body = JSON.generate(body)
      end
      raise Doshii::AuthenticationError.new(response.body) if response.status == 401
      process_response(response)
    rescue Faraday::ConnectionFailed => e
      raise Doshii::ConnectionError.new(e)
    end

    private

    def base64_encoded_key
      key = "#{client_id}:#{client_secret}"
      Base64.urlsafe_encode64 key
    end

    def process_response(res)
      raise Doshii::ResponseError.new(JSON.generate(res.body || {})) if res.status != 200
      return Doshii::Response[{ status: res.status }] if res.body.nil?
      return res.body.collect { |r| Doshii::Response[r] } if res.body.is_a? Array
      Doshii::Response[res.body]
    end
  end
end
