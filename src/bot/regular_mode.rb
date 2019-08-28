module Regular
  def self.say_hello(message)
    "Hello, #{message.from.first_name}!"
  end

  def self.show_help(message)
    "I can't help you, #{message.from.first_name} :("
  end

  def self.show_error(_message)
    'Incorrect command, faggot!'
  end
end