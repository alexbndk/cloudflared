# frozen_string_literal: true

require "test_helper"

# noinspection RubyInstanceMethodNamingConvention
class CloudflaredTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Cloudflared::VERSION
  end
end
