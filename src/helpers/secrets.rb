require_relative 'helper'

module Helper

  class Secrets
    include Singleton
    attr_reader :secrets

    def initialize
      @secrets = ActiveSupport::HashWithIndifferentAccess.new(YAML.load_file(Helper::SECRETS_YAML))
    end

    def self.secrets(key = nil)
      key ? instance.secrets[key] : instance.secrets
    end

  end
end