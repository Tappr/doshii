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

      def subscribe_to_location(id, query = {}, &block)
        request :post, "#{API_URL}/#{id}/subscribe", query, &block
      end

      def unsubscribe_from_location(id, query = {}, &block)
        request :post, "#{API_URL}/#{id}/unsubscribe", query, &block
      end
    end
  end
end

