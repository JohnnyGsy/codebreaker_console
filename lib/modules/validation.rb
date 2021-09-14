# frozen_string_literal: true

module Codebreaker
  module IcodebreakerGem
    def validate_name(name)
      raise ArgumentError, 'Incorrect username' unless name.to_s.match?(/^[0-9a-zA-Z]{3,20}$/)
    end

    def validate_code(code)
      raise ArgumentError, 'Incorrect code' unless code.to_s.match?(/^[1-6]{4}$/)
    end

    def validate_difficulty(difficulty)
      raise ArgumentError, 'No such difficulty' unless %i[easy medium hell].include? difficulty.to_s.to_sym
    end
  end
end
