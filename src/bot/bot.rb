require './src/helpers/helper'
require './src/models/user'

require_relative 'commands/commands'

class Bot
  include Helper
  include Commands

  def initialize
    @api_key = Configurator.secrets(:bot_api_key)
    Configurator.connect_database
  end

  def run
    Telegram::Bot::Client.run(@api_key, logger: Logger.new($stderr)) do |bot|
      begin
        bot.listen do |message|
          user = User.find_or_create(message)
          user.increment_messages_count
          method = case message
                   when Telegram::Bot::Types::CallbackQuery
                     CallbackParser.parse(message.data)
                   when Telegram::Bot::Types::Message
                     CommandParser.parse(message.text)
                   end
          answer = call_method(method, message: message, user: user, bot: bot)
          bot.logger.info("[Bot] #{answer.to_json}")
        rescue Exception => e
          bot.logger.error(e)
          call_method(:show_error, message: message, user: user, bot: bot)
        end
      end
    end
  end

  private

  def call_method(method, message:, user:, bot:)
    send(method, message, user, bot)
  end

end