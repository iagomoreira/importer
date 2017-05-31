module Epos
  class Client
    include HTTParty
    base_uri 'https://api.eposnowhq.com/api/v2'
    headers 'Authorization' => "basic #{ENV['EPOS_API_KEY']}"

    class << self
      def transactions(page: 1)
        get("/transaction?page=#{page}")
      end

      def products(page: 1)
        get("/product?page=#{page}")
      end

      def transaction_items(page: 1)
        get("/transactionitem?page=#{page}")
      end

      def categories(page: 1)
        get("/category?page=#{page}")
      end
    end
  end
end
