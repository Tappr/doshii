module Doshii
  class Client
    module Order
      API_URL = 'orders'

      def order(id)
        get "#{API_URL}/#{id}"
      end

      def create_order(checkin_id, params = {})
        post "#{API_URL}/#{checkin_id}", params
      end

      def update_order(id, params ={})
        put "#{API_URL}/#{checkin_id}", params
      end
    end
  end
end
