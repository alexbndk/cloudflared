module CloudflareDev
  class ImagesResource < Resource
    def list(page: 1, per_page: 50)
      Collection.from_response get_request("images/v1", params: {page: page, per_page: per_page}), key: "images", type: Image
    end
  end
end
