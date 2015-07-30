module Doshii
  class ConnectionError < StandardError; end
  class ConfigurationError < ConnectionError; end
  class AuthenticationError < ConnectionError; end
  class ResponseError < ConnectionError; end
end
