require_relative 'default_commands'
require_relative 'training_commands'

module Commands
  include DefaultCommands
  include TrainingCommands
end