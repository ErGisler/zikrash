module Zikrash
  class ExceptionInfo
    attr_accessor :exception_class
    attr_accessor :message
    attr_accessor :full_backtrace
    attr_accessor :application_backtrace

    def initialize(exception)
      return false unless (exception.respond_to?(:message) && exception.respond_to?(:backtrace))

      self.exception_class = exception.is_a?(Class) ? exception.to_s : exception.class.to_s
      self.message = exception.message
      self.full_backtrace = exception.backtrace
      self.application_backtrace = Rails.backtrace_cleaner.clean(exception.backtrace)

      self
    end

    def data
      all_backtrace, relevant_code = backtrace_with_relevant_code
      {
          class: exception_class,
          message: message,
          location: application_backtrace.first,
          full_backtrace: all_backtrace,
          relevant_code: relevant_code
      }
    end

    private

    def backtrace_with_relevant_code
      relevant_code = {}
      all_backtrace = Rails.backtrace_cleaner.clean(full_backtrace, :all_trace)

      all_backtrace.each_with_index do |backtrace_line, index|
        if application_backtrace.include?(backtrace_line)
          relevant_code[index.to_s] = CodeExtractor.new(backtrace_line).result
        end
      end

      [all_backtrace, relevant_code]
    end
  end
end
