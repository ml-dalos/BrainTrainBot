require_relative 'helper'

module Helper

  class CallbackParser
    # rubocop:disable Metrics/MethodLength, Metrics/LineLength
    def self.parse(callback_data)
      @callback_data = callback_data

      on %r{^next_question$} do
        return :show_next_question
      end

      on %r{^previous_question$} do
        return :show_previous_question
      end

      on %r{^new_package$} do
        return :show_new_package
      end

      :show_undefine_command_error
    end
    # rubocop:enable Metrics/MethodLength, Metrics/LineLength

    def self.on(regexp, &_block)
      yield if block_given? && @callback_data =~ regexp
    end
  end
end