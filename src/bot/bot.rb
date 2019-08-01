require './src/helpers/helper'

require_relative 'command_parser'

class Bot
  include Helper

  def initialize
    @mode    = 'regular'
    @api_key = Secrets.secrets(:bot_api_key)
    run
  end

  private

  def run
    Telegram::Bot::Client.run(@api_key) do |bot|
      bot.listen do |message|
        caller, method = CommandParser.parse(mode: @mode, message: message.text)
        call_method(caller, method)
      end
    end
  end

  def call_method(caller, method)
    p caller
    p method
  end

end