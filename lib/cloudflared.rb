# frozen_string_literal: true

require_relative "cloudflared/version"

module Cloudflared
  autoload :Client, "cloudflared/client"
  autoload :Collection, "cloudflared/collection"
  autoload :Config, "cloudflared/config"
  autoload :Error, "cloudflared/error"
  autoload :Object, "cloudflared/object"
  autoload :Resource, "cloudflared/resource"

  autoload :Image, "cloudflared/objects/image"
  autoload :ImagesResource, "cloudflared/resources/images"

  # Returns Cloudflared's configuration object.
  def self.config
    @config ||= Cloudflared::Config.new
  end

  # Creates a client instance with pre-configured values
  def self.client
    Cloudflared::Client.new(
      api_key: config.api_key,
      account_id: config.account_id,
      images_hash: config.images_hash,
      images_default_key: config.images_default_key,
      adapter: config.adapter || Faraday.default_adapter
    )
  end

  # Lets you set global configuration options.
  #
  # All available options and their defaults are in the example below:
  # @example Initializer for Rails
  #   Cloudflared.configure do |config|
  #     config.api_key      = "key"
  #     config.account_id   = "secret"
  #     config.images_hash  = "hash"
  #     config.images_default_key  = "key"
  #     config.adapter      = Faraday.default_adapter
  #   end
  def self.configure(&block)
    yield(config) if block
  end
end
