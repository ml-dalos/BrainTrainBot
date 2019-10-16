require 'active_record'

class Question < ActiveRecord::Base

  def next
    new_question(self, direction: :next)
  end

  def prev
    new_question(self, direction: :prev)
  end

  def self.current(message_id:, chat_id:)
    Question.where(message_id: message_id,
                   chat_id: chat_id,
                   is_current: true).first
  end

  private

  def new_question(current, direction: :next)
    package = current_package
    current_number = current.number
    new_number = new_number(package.size, current_number, direction)
    question = package.where(number: current_number).first
    question.update!(is_current: false)
    question = package.where(number: new_number).first
    question.update!(is_current: true)
    question
  end

  def new_number(size, current_number, direction)
    case direction.to_sym
    when :next
      current_number == size ? 1 : current_number.next
    when :prev
      current_number == 1 ? size : current_number.pred
    end
  end

  def current_package
    Question.where(message_id: message_id,
                   chat_id: chat_id).order(:number)
  end
end