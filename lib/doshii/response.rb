require 'hashie'

module Doshii
  class Response < Hash
    include Hashie::Extensions::MethodAccess

    def method_missing(name, *args, &block)
      value = super
      return value.collect { |v| Doshii::Response[v] } if value.is_a? Array
      return Response[value] if value.is_a? Hash
      value
    end
  end
end
