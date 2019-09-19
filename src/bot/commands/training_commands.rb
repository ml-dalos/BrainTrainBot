require_relative '../../chgk_package/chgk_package'
require_relative '../../../src/models/question'

module TrainingCommands

  def show_new_package(message, user, bot)
    @package = ChgkPackage::Parser.get_package({})
    question = @package.first
    chat_id = message.chat.id rescue message.from.id
    message_info = bot.api.send_message(chat_id: chat_id, text: question.pretty_inspect, reply_markup: inline_keyboard)

    message_info = ActiveSupport::HashWithIndifferentAccess.new(message_info)
    chat_id = message_info[:result][:chat][:id]
    message_id = message_info[:result][:message_id]
    is_current = true

    @package.each do |question|
      question[:chat_id] = chat_id
      question[:message_id] = message_id
      question[:is_current] = is_current
      is_current = false
      Question.create(question)
    end
  end

  def show_next_question(message, user, bot)
    message_id = message.message.message_id
    chat_id = message.from.id
    package = Question.where(message_id: message_id, chat_id: chat_id).order(:number)
    current_number = package.where(is_current: true).first.number
    next_number = current_number == package.size ? 1 : current_number.next
    question = package.where(number: current_number).first
    question.update!(is_current: false)
    question = package.where(number: next_number).first
    question.update!(is_current: true)
    bot.api.edit_message__text(chat_id: chat_id, message_id: message_id, text: question.pretty_inspect, reply_markup: inline_keyboard)
  end

  def show_previous_question(message, user, bot)
    message_id = message.message.message_id
    chat_id = message.from.id
    package = Question.where(message_id: message_id, chat_id: chat_id).order(:number)
    current_number = package.where(is_current: true).first.number
    prev_number = current_number == 1 ? package.size : current_number.pred
    question = package.where(number: current_number).first
    question.update!(is_current: false)
    question = package.where(number: prev_number).first
    question.update!(is_current: true)
    bot.api.edit_message__text(chat_id: chat_id, message_id: message_id, text: question.pretty_inspect, reply_markup: inline_keyboard)
  end

  private

  def inline_keyboard
    keyboard = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Next question', callback_data: 'next_question'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Previous question', callback_data: 'previous_question'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'New package', callback_data: 'new_package')
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard)
  end

end