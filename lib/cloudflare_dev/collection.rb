module CloudflareDev
  class Collection
    include Enumerable

    MAX_PER_PAGE = 100

    attr_reader :data, :success, :errors, :page, :per_page

    def self.from_response(response, key:, type:)
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

    def each(&block)
      @data.each(&block)
    end
  end
end