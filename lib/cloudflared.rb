# frozen_string_literal: true

require_relative "cloudflared/version"

module Cloudflared
  autoload :Client, "cloudflared/client"
  autoload :Error, "cloudflared/error"
  autoload :Collection, "cloudflared/collection"
  autoload :Object, "cloudflared/object"
  autoload :Resource, "cloudflared/resource"

  autoload :Image, "cloudflared/objects/image"
  autoload :ImagesResource, "cloudflared/resources/images"
end
