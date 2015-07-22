module Doshii
  class Client
    module Order
      API_URL = 'orders'

      def create_order(checkin_id, query = {}, &block)
        process_response(request :post, "#{API_URL}/#{checkin_id}", query, &block)
      end

      def get_order(id)
        process_response(request :get, "#{API_URL}/#{id}")
      end

      def update_order(id, query = {}, &block)
        process_response(request :put, "#{API_URL}/#{id}", query, &block)
      end
    end
  end
end
