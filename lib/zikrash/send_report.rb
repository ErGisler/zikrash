require 'net/http'
require 'uri'
require 'json'

module Zikrash
  class SendReport
    def initialize(exception_info_data)
      uri = URI.parse(SEND_TO_URL)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.path, {"Content-Type" => "application/json"})
      request.body = {exception_info: exception_info_data}.to_json

      http.request(request)
    end
  end
end
