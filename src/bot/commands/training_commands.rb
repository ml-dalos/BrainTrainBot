require_relative '../../chgk_package/chgk_package'
require_relative '../../../src/models/question'

module TrainingCommands

  def show_new_package(message, _user, bot)
    # need to generate keyboard with filters and then generate new package
    @package = ChgkPackage::Parser.get_package({})
    question = @package.first
    chat_id = message.chat.id rescue message.from.id
    message_info = bot.api.send_message(chat_id: chat_id, text: generate_question_message(question), reply_markup: inline_keyboard)

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

  def show_next_question(message, _user, bot)
    change_question_message(message, bot, direction: :next)
  end

  def show_previous_question(message, _user, bot)
    change_question_message(message, bot, direction: :prev)
  end

  def show_answer(message, _user, bot)
    question = current_question(message)
    return if question.nil?
    return if message.message.text =~ /.+\nAnswer:.+/i

    bot.api.edit_message__text(chat_id: question.chat_id,
                               message_id: question.message_id,
                               text: generate_answer_message(question),
                               reply_markup: inline_keyboard(show_answer: false))
  end

  private

  def change_question_message(message, bot, direction: :next)
    question = current_question(message)
    return if question.nil?

    question = case direction
               when :next
                 question.next
               when :prev
                 question.prev
               end
    bot.api.edit_message__text(chat_id: question.chat_id,
                               message_id: question.message_id,
                               text: generate_question_message(question),
                               reply_markup: inline_keyboard,
                               parse_mode: 'HTML')
  end

  def inline_keyboard(show_answer: true)
    keyboard = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Show answer', callback_data: 'show_answer'),
      [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: '<< Prev', callback_data: 'previous_question'),
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Next  >>', callback_data: 'next_question')
      ],
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'New package', callback_data: 'new_package')
    ]
    keyboard.shift unless show_answer
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard)
  end

  def current_question(message)
    message_id = message.message.message_id
    chat_id = message.from.id
    Question.current(message_id: message_id, chat_id: chat_id)
  end

  def generate_question_message(question)
    text = 'Source: '
    text << question[:origin] << "\n"
    text << 'Question: ' << question[:text]
    text << question[:images].to_s unless question[:images].empty?
    text
  end

  def generate_answer_message(question)
    text = 'Source: '
    text << question[:origin] << "\n"
    text << 'Question: ' << question[:text] << "\n"
    text << 'Answer: ' << question[:answer] << "\n"
    text << 'Comment: ' << question[:comment] << "\n"
    text << question[:images].to_s unless question[:images].empty?
    text
  end

end