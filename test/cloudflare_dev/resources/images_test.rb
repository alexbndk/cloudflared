require "test_helper"

class ImagesResourceTest < Minitest::Test
  def teardown
    Faraday.default_connection = nil
  end

  def test_list
    stub = stub_request("images/v1", response: stub_response(fixture: "images/list"))
    client = CloudflareDev::Client.new(api_key: "fake", account_id: "fake", stubs: stub)
    images = client.images.list
    assert_equal CloudflareDev::Collection, images.class
    assert_equal CloudflareDev::Image, images.data.first.class
    assert_equal 2, images.count
  end
end