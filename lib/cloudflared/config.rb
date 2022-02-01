module Cloudflared
  # Class used to initialize configuration object.
  class Config
    attr_accessor :api_key
    attr_accessor :account_id
    attr_accessor :images_hash
    attr_accessor :images_default_key
    attr_accessor :adapter
    attr_accessor :stubs

    def initialize
    end
  end
end
