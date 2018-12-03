require 'zikrash/version'
require 'zikrash/exception_info'
require 'zikrash/code_extractor'
require 'zikrash/send_report'

module Zikrash
  SEND_TO_URL = 'http://127.0.0.1/billing/test/get_report/'

  class << self
    def report(exception)
      SendReport.new(ExceptionInfo.new(exception).data)
    end
  end
end
