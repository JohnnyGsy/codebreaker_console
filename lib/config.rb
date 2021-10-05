# frozen_string_literal: true

require 'yaml'
require 'i18n'
require 'psych'
require_relative 'modules/validation'
require_relative 'modules/storage'

require_relative 'game_core'
require_relative 'game'
require_relative 'icodebreaker_gem/version'
require_relative 'icodebreaker_gem'

I18n.load_path << Dir[['config', 'locales', '**', '*.yml'].join('/')]
