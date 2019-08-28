require 'active_record'

class User < ActiveRecord::Base
  def self.find_or_create(message)
    user_info = message.from
    find_or_create_by(uid: user_info.id) do |user|
      user.uid = user_info.id
      user.first_name = user_info.first_name
      user.last_name = user_info.last_name
      user.username = user_info.username
    end
  end
end