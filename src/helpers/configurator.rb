require_relative 'helper'

module Helper
  class Configurator
    include Singleton
    attr_reader :secrets, :database

    def initialize
      @secrets = load_yaml(Helper::SECRETS_YAML)
      @database = load_yaml(Helper::DATABASE_YAML)
    end

    def self.secrets(key = nil)
      key ? instance.secrets[key] : instance.secrets
    end

    def self.database
      instance.database
    end

    def load_yaml(config_name)
      ActiveSupport::HashWithIndifferentAccess.new(YAML.load_file(config_name))
    end
  end
end