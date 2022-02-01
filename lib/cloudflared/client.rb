require "faraday"

module Cloudflared
  class Client
    BASE_URL = "https://api.cloudflare.com/client/v4/accounts"

    attr_reader :api_key, :account_id, :adapter, :images_hash, :images_default_key, :stubs

    # Initializes a new Cloudflare client.
    #
    # @!attribute api_key
    #   @return [String] The Cloudflare api key to use
    #
    # @!attribute account_id
    #   @return [String] The Cloudflare account id to use
    #
    # @!attribute images_hash
    #   @return [String] The Cloudflare images hash found on the images dashboard. This is used for image delivery urls.
    #
    # @!attribute images_default_key
    #   @return [String] The default key for signing private images
    #
    # @!attribute adapter
    #   @return [Symbol] The Faraday adapter to use
    #
    # @!attribute stubs
    #   @return [Symbol] Stubs for use in testing
    #
    # @return [Cloudflared]
    def initialize(api_key:, account_id:, images_hash:, images_default_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter
      @account_id = account_id
      @images_hash = images_hash
      @images_default_key = images_default_key
      @stubs = stubs
    end

    # Accesses the Cloudflare Images developer platform
    def images
      ImagesResource.new(self)
    end

    # Creates a new connection with the given request type.
    #
    # @!attribute request_type
    #   @return [JSON] The request type to use (e.g. application/json)
    def connection(request_type: :json)
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = "#{BASE_URL}/#{@account_id}"
        conn.request request_type
        conn.response :json, content_type: "application/json"
        conn.adapter @stubs.nil? ? adapter : :test, @stubs
      end
    end
  end
end
