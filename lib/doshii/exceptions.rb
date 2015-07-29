module Doshii
  class ConnectionError < StandardError; end
  class AuthenticationError < ConnectionError; end
  class ResponseError < ConnectionError; end
end
