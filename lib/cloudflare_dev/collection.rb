module CloudflareDev
  class Collection
    MAX_PER_PAGE = 100

    def self.from_response(response, key: "images", type: Cloudflare::Images::Image)
      body = response.body["result"]
      new(
        data: body[key].map { |attrs| type.new(attrs) },
        success: body["success"],
        errors: body["errors"],
        messages: body["messages"]
      )
    end

    def initialize(data:, success:, errors:, messages:, page: 1, per_page: 50)
      @data = data
      @success = success
      @errors = errors
      @messages = messages
      @page = page
      @per_page = per_page
    end
  end
end