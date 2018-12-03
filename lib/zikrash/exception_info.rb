module Zikrash
  class ExceptionInfo
    attr_accessor :exception_class
    attr_accessor :message
    attr_accessor :full_backtrace
    attr_accessor :location
    attr_accessor :relevant_code

    def initialize(exception)
      self.exception_class = exception.is_a?(Class) ? exception.to_s : exception.class.to_s
      self.message = exception.message
      self.full_backtrace = exception.backtrace
      self.location = exception.backtrace.first
      self.relevant_code = CodeExtractor.new(exception.backtrace.first).result
      self
    end

    def data
      {
          class: exception_class,
          message: message,
          full_backtrace: full_backtrace,
          location: location,
          relevant_code: relevant_code
      }
    end
  end
end
