require_relative 'helper'

module Helper

  class CommandParser
    # rubocop:disable Metrics/MethodLength, Metrics/LineLength
    def self.parse(message_text)
      @message_text = message_text

      on %r{^/help$} do
        return :show_help
      end

      on %r{^/hello$} do
        return :say_hello
      end

      on %r{^/start$} do
        return :say_hello
      end

      on %r{^/show_uid$} do
        return :show_uid
      end

      on %r{^/get_package$} do
        return :show_new_package
      end

      :show_undefine_command_error
    end
    # rubocop:enable Metrics/MethodLength, Metrics/LineLength

    def self.on(regexp, &_block)
      yield if block_given? && @message_text =~ regexp
    end
  end
end