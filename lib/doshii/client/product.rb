module Doshii
  class Client
    module Product
      API_URL = 'products'

      def list_products(location_id)
        request :get, "#{API_URL}/#{location_id}"
      end
    end
  end
end
