# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "cloudflare_dev"
require "minitest/autorun"
require "faraday"
require "json"

TEST_BASE_URL = "/client/v4/accounts/fake"

class Minitest::Test
  def stub_response(fixture:, status: 200, headers: {"Content-Type" => "application/json"})
    if headers.dig("Content-Type").include? "application/json"
      [status, headers, File.read("test/fixtures/#{fixture}.json")]
    else
      [status, headers, File.read("test/fixtures/#{fixture}")]
    end
  end

  def stub_request(path, response:, method: :get, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      arguments = [method, "#{TEST_BASE_URL}/#{path}"]
      arguments << body.to_json if [:post, :put, :patch].include?(method)
      stub.send(*arguments) { |_env| response }
    end
  end
end
