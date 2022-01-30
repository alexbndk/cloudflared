require "faraday"
require "marcel"
require "faraday/multipart"

module CloudflareDev
  class Resource
    attr_reader :client
    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, default_headers.merge(headers))
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, default_headers.merge(headers))
    end

    def upload_request(url, file:, params: {}, headers: {})
      params[:file] = Faraday::Multipart::FilePart.new(
        file,
        Marcel::MimeType.for(Pathname.new(file))
      )

      handle_response client.connection(request_type: :multipart).post(url, params, default_headers.merge(headers))
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, default_headers.merge(headers))
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, default_headers.merge(headers))
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection.delete(url, params, default_headers.merge(headers))
    end

    def default_headers
      {Authorization: "Bearer #{client.api_key}"}
    end

    def handle_response(response)

      if response.body.is_a? Hash
        message = response.body["errors"]&.map{ |error| error["message"]}&.join(" ")
      else
        message = response.body.inspect
      end


      case response.status
      when 400
        raise Error, "Bad request, the request was invalid. #{message}"
      when 401
        raise Error, "Unauthorized, the user does not have permission. #{message}"
      when 403
        raise Error, "Forbidden, the request was not authenticated. #{message}"
      when 404
        raise Error, "Not found, the resource was not found. #{message}"
      when 429
        raise Error, "Too many requests, client is rate limited. #{message}"
      when 405
        raise Error, "Method not allowed, incorrect HTTP method provided. #{message}"
      when 415
        raise Error, "Unsupported media type, response is not valid JSON. #{message}"
      when 500
        raise Error, "Server error. #{message}"
      else
        response
      end
    end
  end
end
