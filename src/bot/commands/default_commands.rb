module DefaultCommands
  def say_hello(message, _user, bot)
    answer = "Hello, #{message.from.first_name}!"
    bot.api.send_message(chat_id: message.chat.id, text: answer)
  end

  def show_help(message, _user, bot)
    answer = "I can't help you, #{message.from.first_name} :("
    bot.api.send_message(chat_id: message.chat.id, text: answer)
  end

  def show_uid(message, user, bot)
    answer = "Yours Telegram ID is #{user.uid}"
    bot.api.send_message(chat_id: message.chat.id, text: answer)
  end

  def show_undefine_command_error(message, _user, bot)
    chat_id = message.chat.id rescue message.message.chat.id
    answer = "Sorry, I don't understand you. Please, try another command."
    bot.api.send_message(chat_id: chat_id, text: answer)
  end

  def show_error(message, _user, bot)
    chat_id = message.chat.id rescue message.message.chat.id
    answer = 'Oooops! Something went wrong 😥'
    bot.api.send_message(chat_id: chat_id, text: answer)
  end
end