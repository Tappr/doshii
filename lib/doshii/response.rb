require 'hashie'

module Doshii
  class Response
    extend Forwardable

    def_delegators :@response, :headers, :status

    def initialize(response)
      @response = response
    end

    def headers
      mash(raw_headers)
    end

    private

    def mash(args)
      Hashie::Mash.new(*args)
      # args.map {}
    end

    def raw_body
      @response.body
    end

    def raw_headers
      @response.headers
    end
  end
end
