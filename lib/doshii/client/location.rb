module Doshii
  class Client
    module Location
      API_URL = 'locations'

      def list_locations
        request :get, API_URL
      end

      def create_location(query = {}, &block)
        request :post, API_URL, query, &block
      end
    end
  end
end

