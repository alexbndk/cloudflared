require "openssl"
require "pathname"

module CloudflareDev
  class ImagesResource < Resource
    # ONE_DAY = 60 * 60 * 24
    # ONE_HOUR = 60 * 60
    # THIRTY_MINUTES = 60 * 30
    FIFTEEN_MINUTES = 60 * 15
    IMAGE_DELIVERY_URL = "https://imagedelivery.net"

    def delete(file_id:, **params)
      delete_request("images/v1/#{file_id}", params: params)
      true
    end

    def details(file_id:, **params)
      Image.new get_request("images/v1/#{file_id}", params: params).body.dig("result")
    end

    def direct_upload_url(**params)
      post_request("images/v1/direct_upload", body: params).body.dig("result", "uploadURL")
    end

    def download(file_id:, **params)
      get_request("images/v1/#{file_id}/blob", params: params).body
    end

    def list(**params)
      Collection.from_response get_request("images/v1", params: params), key: "images", type: Image
    end

    def public_url(path)
      "#{IMAGE_DELIVERY_URL}/#{@client.images_hash}/#{path}"
    end

    def signed_url(path, key:, expiry_seconds: FIFTEEN_MINUTES)
      # The path uses the image + the file_id (and a variant if passed through)
      path = path[1..] if path[0] == "/"
      path = "#{@client.images_hash}/#{path}"

      # Calculate the hexdigest with the  leading slash
      sig = OpenSSL::HMAC.hexdigest("SHA256", key, "/#{path}")

      # Calculate the seconds since the epoch in the future
      exp = Time.new.to_i + expiry_seconds

      # Respond with the url
      qry = path.include?("?") ? "&" : "?"
      "#{IMAGE_DELIVERY_URL}/#{path}#{qry}sig=#{sig}&exp=#{exp}"
    end

    def stats(**params)
      get_request("images/v1/stats", params: params).body.dig("result")
    end

    def update(file_id:, **params)
      Image.new patch_request("images/v1/#{file_id}", body: params).body.dig("result")
    end

    def upload(file:, **params)
      Image.new upload_request("images/v1", file: file, params: params).body.dig("result")
    end
  end
end
