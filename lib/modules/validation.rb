# frozen_string_literal: true

module IcodebreakerGem
  module Validation
    USERNAME = /^[0-9a-zA-Z]{3,20}$/.freeze
    CODE = /^[1-6]{4}$/.freeze

    def validate_name(name)
      raise ArgumentError, 'Incorrect username' unless name.to_s.match?(USERNAME)
    end

    def validate_code(code)
      raise ArgumentError, 'Incorrect code' unless code.to_s.match?(CODE)
    end

    def validate_difficulty(difficulty)
      raise ArgumentError, 'No such difficulty' unless %i[easy medium hell].include? difficulty.to_s.to_sym
    end
  end
end
