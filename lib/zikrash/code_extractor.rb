require 'pathname'

module Zikrash
  class CodeExtractor
    attr_accessor :file_location
    attr_accessor :line_number

    def initialize(backtrace_line)
      self.file_location = "#{Rails.root}/#{backtrace_line.split(':')[0]}"
      self.line_number = backtrace_line.split(':')[1].to_i
      self
    end

    def result
      retrieve_code_lines
    end

    private

    def retrieve_code_lines
      code_lines = {}
      File.open(Pathname.new(file_location).realpath.to_s) do |file|
        file.each_line.with_index(1) do |line, index|
          code_lines[index] = line if index.between?(line_number - 5, line_number + 5)
          break if index > line_number + 5
        end
      end
      code_lines
    end
  end
end
