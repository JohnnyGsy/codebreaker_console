# frozen_string_literal: true

module IcodebreakerGem
  STATUS = %i[go_on over].freeze
  RESULT = %i[win lose].freeze
  DIFFICULTIES = {
    easy: {
      attempts_total: 15,
      hints_total: 2
    },
    medium: {
      attempts_total: 10,
      hints_total: 1
    },
    hell: {
      attempts_total: 5,
      hints_total: 1
    }
  }.freeze
end
