require_relative '../../../src/chgk_pakage/chgk_package'

module TrainingCommands

  def show_trainnig_filters(message, user, bot)

  end

  def show_new_package(message, user, bot)
    @package = ChgkPackage::Parser.get_package({})
    show_next_question(message, user, bot)
  end

  def show_next_question(message, user, bot)
    question = @package.pop
    unless question
      say_about_empty_package(message, user, bot)
      return
    end
  end

  private

  def say_about_empty_package(message, _user, bot)
    answer = "Sorry, your generated package is over.\n Please, generate the new one by /get_package command"
    bot.api.send_message(chat_id: message.chat.id, text: answer)
  end

end