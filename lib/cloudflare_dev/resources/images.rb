require "pathname"

module CloudflareDev
  class ImagesResource < Resource

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
