require 'zikrash/version'
require 'zikrash/exception_info'
require 'zikrash/code_extractor'
require 'zikrash/send_report'
require 'logger'

module Zikrash
  class << self
    def report(project_key, exception, session_info = {}, params_info = {},  additional_reports = {})
      return false if project_key.blank? || exception.blank?

      begin
        exception_info = ExceptionInfo.new(exception)
        return false unless exception_info

        send_report = SendReport.new(project_key, exception_info.data, session_info, params_info, additional_reports)

        send_report.let_it_go
      rescue Exception => error
        # Just in case I messed up badly
        Rails.logger.fatal("========== Zikrash Gem Crashed ==========")
        Rails.logger.fatal("Please notify it's developers")
        Rails.logger.fatal("Exception message: #{error.message}")
        Rails.logger.fatal("Exception location: #{error.backtrace.first}")
        Rails.logger.fatal("=========================================\n")
      end
    end
  end
end
