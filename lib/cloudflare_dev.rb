# frozen_string_literal: true

require_relative "cloudflare_dev/version"

module CloudflareDev
  autoload :Client, "cloudflare_dev/client"
  autoload :Error, "cloudflare_dev/error"
  autoload :Collection, "cloudflare_dev/collection"
  autoload :Object, "cloudflare_dev/object"
  autoload :Resource, "cloudflare_dev/resource"

  autoload :Image, "cloudflare_dev/objects/image"
  autoload :ImagesResource, "cloudflare_dev/resources/images"
end

