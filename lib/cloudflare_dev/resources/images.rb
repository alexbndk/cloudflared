module CloudflareDev
  class ImagesResource < Resource
    def upload(file:, **params)
      Image.new upload_request("images/v1", file: file, params: params).body.dig("result")
    end

    def update(file_id:, **params)
      Image.new post_request("images/v1/#{file_id}", body: "", params: params).body.dig("result")
    end

    def direct_upload_url(**params)
      post_request("images/v1/direct_upload", body: "", params: params).body.dig("result", "uploadURL")
    end

    def list(**params)
      Collection.from_response get_request("images/v1", params: params), key: "images", type: Image
    end

    def details(file_id:, **params)
      Image.new get_request("images/v1/#{file_id}", params: params).body.dig("result")
    end

    def download(file_id:, **params)
      get_request("images/v1/#{file_id}/blob", params: params)
    end

    def delete(file_id:, **params)
      delete_request("images/v1/#{file_id}", params: params)
      true
    end

    def stats(**params)
      get_request("images/v1/stats", params: params).body.dig("result")
    end
  end
end
