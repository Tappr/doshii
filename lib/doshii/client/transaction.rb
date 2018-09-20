module Doshii
  class Client
    module Transaction
      API_URL = 'transactions'

      def create_transaction(query = {}, &block)
        request :post, API_URL, query, &block
      end

      def get_transaction(id)
        request :get, "#{API_URL}/#{id}"
      end

      def update_transaction(id, query = {}, &block)
        request :put, "#{API_URL}/#{id}", query, &block
      end
    end
  end
end
