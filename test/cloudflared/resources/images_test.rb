require "test_helper"

# noinspection RubyInstanceMethodNamingConvention
class ImagesResourceTest < Minitest::Test
  def teardown
    Faraday.default_connection = nil
  end

  def test_delete
    file_id = "ZxR0pLaXRldlBtaFhhO2FiZGVnaA"
    stub = stub_request("images/v1/#{file_id}", response: stub_response(fixture: "images/delete"), method: :delete)
    client = create_stubbed_client(stub)
    assert client.images.delete(file_id: file_id)
  end

  def test_details
    file_id = "ZxR0pLaXRldlBtaFhhO2FiZGVnaA"
    stub = stub_request("images/v1/#{file_id}", response: stub_response(fixture: "images/image"), method: :get)
    client = create_stubbed_client(stub)
    image = client.images.details(file_id: file_id)
    assert_equal Cloudflared::Image, image.class
    assert_equal file_id, image.id
    assert_equal "avatar.png", image.filename
  end

  def test_direct_upload_url
    stub = stub_request("images/v1/direct_upload", method: :post, body: {}, response: stub_response(fixture: "images/direct_upload"))
    client = create_stubbed_client(stub)
    url = client.images.direct_upload_url
    assert_equal "https://upload.imagedelivery.net/fgr33htrthytjtyereifjewoi338272s7w1383", url
  end

  def test_direct_upload_url_with_expiry
    expiry = (DateTime.new + 1).rfc3339
    stub = stub_request("images/v1/direct_upload", method: :post, body: {expiry: expiry}, response: stub_response(fixture: "images/direct_upload"))
    client = create_stubbed_client(stub)
    url = client.images.direct_upload_url(expiry: expiry)
    assert_equal "https://upload.imagedelivery.net/fgr33htrthytjtyereifjewoi338272s7w1383", url
  end

  def test_download
    file_id = "ZxR0pLaXRldlBtaFhhO2FiZGVnaA"
    stub = stub_request("images/v1/#{file_id}/blob", response: stub_response(fixture: "images/blob.png", headers: {"Content-Type" => "application/octet-stream"}), method: :get)
    client = create_stubbed_client(stub)
    response = client.images.download(file_id: file_id)
    assert_equal response, File.read("test/fixtures/images/blob.png")
  end

  def test_list
    stub = stub_request("images/v1", response: stub_response(fixture: "images/list"), method: :get)
    client = create_stubbed_client(stub)
    images = client.images.list
    assert_equal Cloudflared::Collection, images.class
    assert_equal Cloudflared::Image, images.data.first.class
    assert_equal 2, images.count
  end

  def test_public_url
    expected = "https://imagedelivery.net/hello/world"
    client = create_stubbed_client(nil, images_hash: "hello")
    url = client.images.public_url("world")
    assert_equal expected, url
  end

  def test_signed_url_signature
    # key = "this is a secret"
    path = "world"
    fifteen_minutes = 60 * 15
    expected = "https://imagedelivery.net/hello/world?sig=6293f9144b4e9adc83416d1b059abcac750bf05b2c5c99ea72fd47cc9c2ace34&exp=#{Time.new.to_i + fifteen_minutes}"
    client = create_stubbed_client(nil, images_hash: "hello", images_default_key: "this is a secret")
    url = client.images.signed_url(path)
    assert_equal expected, url
  end

  def test_signed_url_signature_without_leading_slash
    # key = "this is a secret"
    path = "world"
    fifteen_minutes = 60 * 15
    expected = "https://imagedelivery.net/hello/world?sig=6293f9144b4e9adc83416d1b059abcac750bf05b2c5c99ea72fd47cc9c2ace34&exp=#{Time.new.to_i + fifteen_minutes}"
    client = create_stubbed_client(nil, images_hash: "hello", images_default_key: "this is a secret")
    url = client.images.signed_url(path)
    assert_equal expected, url
  end

  def test_signed_url_signature_with_expiry
    # key = "this is a secret"
    path = "world"
    one_day = 60 * 60 * 24
    expected = "https://imagedelivery.net/hello/world?sig=6293f9144b4e9adc83416d1b059abcac750bf05b2c5c99ea72fd47cc9c2ace34&exp=#{Time.new.to_i + one_day}"
    client = create_stubbed_client(nil, images_hash: "hello", images_default_key: "this is a secret")
    url = client.images.signed_url(path, expiry_seconds: one_day)
    assert_equal expected, url
  end

  def test_stats
    stub = stub_request("images/v1/stats", response: stub_response(fixture: "images/stats"), method: :get)
    client = create_stubbed_client(stub)
    response = client.images.stats
    assert_equal Hash, response.class
    assert_equal 1000, response.dig("count", "current")
    assert_equal 100000, response.dig("count", "allowed")
  end

  def test_update
    file_id = "ZxR0pLaXRldlBtaFhhO2FiZGVnaA"
    body = {requireSignedURLs: true}
    stub = stub_request("images/v1/#{file_id}", method: :patch, body: body, response: stub_response(fixture: "images/image"))
    client = create_stubbed_client(stub)
    image = client.images.update(file_id: file_id, requireSignedURLs: true)
    assert_equal Cloudflared::Image, image.class
    assert_equal true, image.requireSignedURLs
  end
end
