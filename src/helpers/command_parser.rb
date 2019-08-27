require_relative 'helper'

module Helper

  class CommandParser
    # rubocop:disable Metrics/MethodLength, Metrics/LineLength
    def self.parse(mode: 'regular', message:)
      # Bot::Logger.write(self, "Get mode: '#{mode}', message: '#{message}'")
      puts "Get mode: '#{mode}', message: '#{message}'"
      object, method = case [mode, message]
                       # Section with all accepted commands in format:
                       # when %w[<mode> <message>]
                       #   %i[<class>, <method>]
                       when %w[regular /start]
                         %i[Regular say_hello]
                       when %w[regular /help]
                         %i[Regular show_help]
                       # end of commands section
                       else
                         'Undefined command'
                       end
      # Logger.write(self, "Return method: '#{method}' for class: '#{object}'")
      [object, method]
    end
    # rubocop:enable Metrics/MethodLength, Metrics/LineLength
  end
end