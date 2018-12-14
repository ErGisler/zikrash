require 'net/http'
require 'uri'
require 'json'
require 'base64'

module Zikrash
  class SendReport
    attr_accessor :project_key
    attr_accessor :exception_info_data
    attr_accessor :session_info
    attr_accessor :params_info
    attr_accessor :additional_reports

    def initialize(project_key, exception_info_data, session_info, params_info, additional_reports)
      self.project_key = project_key
      self.exception_info_data = exception_info_data
      self.session_info = session_info
      self.params_info = params_info
      self.additional_reports = additional_reports
    end

    def let_it_go
      project_url = unwrap_project_url

      begin
        uri = URI.parse(project_url)
        uri.kind_of?(URI::HTTP)
      rescue URI::InvalidURIError
        return false
      end

      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = form_request_body

      http.request(request)
    end

    private

    def unwrap_project_url
      Base64.decode64(project_key)
    end

    def form_request_body
      {
          exception_info: exception_info_data,
          session_info: session_info,
          params_info: params_info,
          additional_reports: additional_reports
      }.to_json
    end
  end
end
