require "faraday"

module CloudflareDev
  class Client
    BASE_URL = "https://api.cloudflare.com/client/v4/accounts"

    attr_reader :api_key, :adapter

    def initialize(api_key:, account_id:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
      @account_id = account_id
    end

    def images
      ImagesResource.new(self)
    end

    def connection(request_type: :json)
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = "#{BASE_URL}/#{@account_id}"
        conn.request request_type
        conn.response :json, content_type: "application/json"
      end
    end
  end
end
