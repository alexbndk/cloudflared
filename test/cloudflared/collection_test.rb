# frozen_string_literal: true

require "test_helper"

# noinspection RubyInstanceMethodNamingConvention
class CollectionTest < Minitest::Test
  def setup
    response = OpenStruct.new({body: {}})
    response.body = JSON.parse(File.read("test/fixtures/images/list.json"))
    @collection = Cloudflared::Collection.from_response(response, key: "images", type: Cloudflared::Image)
  end

  def test_responds_to_enumerable_methods
    assert_equal Cloudflared::Collection, @collection.class
    assert @collection.respond_to? :each
    assert @collection.respond_to? :map
    assert @collection.respond_to? :select
    assert_equal 2, @collection.count
  end

  def test_iterates_over_data
    expected = %w[avatar.png avatar2.png]
    assert_equal expected, @collection.map { |o| o.filename }
  end
end
