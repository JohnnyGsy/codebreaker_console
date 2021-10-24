# frozen_string_literal: true

module IcodebreakerGem
  module Validation
    USERNAME = /^[0-9a-zA-Z]{3,20}$/.freeze
    CODE = /^[1-6]{4}$/.freeze

    def validate_name(name)
      return unless name.to_s.match?(USERNAME)

      true
    end

    def validate_code(code)
      return unless code.to_s.match?(CODE)

      true
    end

    def validate_difficulty(difficulty)
      return unless %i[easy medium hell].include? difficulty.to_s.to_sym

      true
    end
  end
end
