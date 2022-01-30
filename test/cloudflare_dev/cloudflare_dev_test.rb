# frozen_string_literal: true

require "test_helper"

# noinspection RubyInstanceMethodNamingConvention
class CloudflareDevTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CloudflareDev::VERSION
  end
end
