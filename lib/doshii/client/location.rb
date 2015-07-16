module Doshii
  class Client
    module Location
      API_URL = 'locations'

      def locations
        get API_URL
      end

      def create_location(query = {}, &body_block)
        post API_URL, query, &body_block
      end
    end
  end
end
