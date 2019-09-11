require 'active_support/core_ext/hash/indifferent_access'
require 'active_record'
require 'telegram/bot'
require 'logger'
require 'yaml'
require 'singleton'
require 'pry'

require_relative 'configurator'
require_relative 'command_parser'
require_relative 'callback_parser'

module Helper
  LOG_DIR = 'stats/'.freeze
  DEBUG_LOG_FILE = "#{LOG_DIR}debug.log".freeze

  CONFIGS_DIR = 'configs/'.freeze
  SECRETS_YAML = "#{CONFIGS_DIR}secrets.yaml".freeze
  DATABASE_YAML = "#{CONFIGS_DIR}database.yaml".freeze
end