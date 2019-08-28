require './src/helpers/helper'

require_relative 'regular_mode'

class Bot
  include Helper

  def initialize
    @mode    = 'regular'
    @api_key = Configurator.secrets(:bot_api_key)
    Configurator.init_database
  end

  def run
    Telegram::Bot::Client.run(@api_key) do |bot|
      bot.listen do |message|
        puts message.pretty_inspect
        caller, method = CommandParser.parse(mode: @mode, message: message.text)
        answer = call_method(caller, method, message)
        answer = 'Shit!' if !answer || answer.empty?
        bot.api.send_message(chat_id: message.chat.id, text: answer)
      end
    end
  end

  private

  def call_method(caller, method, message)
    module_name = Object.const_get(caller)
    module_name.send(method, message)
  end

end