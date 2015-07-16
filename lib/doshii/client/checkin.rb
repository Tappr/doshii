module Doshii
  class Client
    module Checkin
      API_URL = 'checkins'

      def checkin(id)
        get "#{API_URL}/#{id}"
      end

      def create_checkin(location_id, params = {})
        post "#{API_URL}/#{location_id}", params
      end

      def delete_checkin(id)
        delete "#{API_URL}/#{id}"
      end
    end
  end
end
