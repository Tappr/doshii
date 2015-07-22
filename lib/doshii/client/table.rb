module Doshii
  class Client
    module Table
      API_URL = 'tables'

      def get_table(id)
        process_response(request :get, "#{API_URL}/#{id}")
      end
    end
  end
end
