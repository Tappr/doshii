module Doshii
  class Client
    module Product
      API_URL = 'products'

      def products(location_id)
        get "#{API_URL}/#{location_id}"
      end
    end
  end
end
