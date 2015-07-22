module Doshii
  class Client
    module Checkin
      API_URL = 'checkins'

      def allocate_table(checkin_id, query = {}, &block)
        process_response(request :post, "#{API_URL}/#{checkin_id}", query, &block)
      end

      def create_checkin(location_id, query = {}, &block)
        process_response(request :post, "#{API_URL}/#{location_id}", query, &block)
      end

      def delete_checkin(id)
        process_response(request :delete, "#{API_URL}/#{id}")
      end

      def get_checkin(id)
        process_response(request :get, "#{API_URL}/#{id}")
      end

      def update_checkin(id, query = {}, &block)
        process_response(request :put, "#{API_URL}/#{id}", query, &block)
      end
    end
  end
end
