module Doshii
  class ConnectionError < StandardError; end
  class AuthenticationError < ConnectionError; end
end
