# frozen_string_literal: true
require_relative 'config1.rb'

I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]