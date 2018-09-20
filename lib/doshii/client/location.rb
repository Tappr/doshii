module Doshii
  class Client
    module Location
      API_URL = 'locations'

      def get_locations
        request :get, API_URL
      end

      def get_location(id)
        request :get, "#{API_URL}/#{id}"
      end

      def create_location(query = {}, &block)
        request :post, API_URL, query, &block
      end
    end
  end
end

