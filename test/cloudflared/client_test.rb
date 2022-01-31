require "test_helper"

class ClientTest < Minitest::Test
  def test_api_key
    client = Cloudflared::Client.new api_key: "test", account_id: "test"
    assert_equal "test", client.api_key
    assert_equal "test", client.account_id
  end
end
