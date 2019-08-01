require 'active_support/core_ext/hash/indifferent_access'
require 'telegram/bot'
require 'yaml'
require 'singleton'
require 'pry'

require_relative 'secrets'
require_relative 'logger'

module Helper
  CONFIGS_DIR = 'configs/'.freeze
  SECRETS_YAML = "#{CONFIGS_DIR}secrets.yaml".freeze
end