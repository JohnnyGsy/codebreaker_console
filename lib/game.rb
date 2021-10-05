# frozen_string_literal: true

module IcodebreakerGem
  class Game
    include Validation
    include Storage

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

    attr_reader :name, :difficulty, :attempts_used, :hints_used, :status, :result

    def initialize(name = 'User1', difficulty = :easy, secret = GameCore.random)
      validate_name name
      validate_difficulty difficulty

      @name = name.to_s
      @difficulty = difficulty.to_sym

      @attempts_used = 0
      @hints_used = 0

      @status = :go_on
      @result = nil

      @code = GameCore.new(secret)
    end

    def attempts_total
      DIFFICULTIES[difficulty][:attempts_total]
    end

    def hints_total
      DIFFICULTIES[difficulty][:hints_total]
    end

    def attempt(attempt_code)
      case @status
      when :go_on
        @attempts_used += 1
        answer = @code.compare(attempt_code)
        check_win(answer)
        check_lose
        answer
      when :over
        I18n.t('message.lose')
      end
    end

    def hint
      case @status
      when :go_on
        return I18n.t('message.no_hints') if @hints_used >= hints_total

        @hints_used += 1
        @code.hint
      when :over
        I18n.t('message.lose')
      end
    end

    def game_data
      {

        name: name,
        difficulty: difficulty.to_s,
        attempts_total: attempts_total,
        attempts_used: attempts_used,
        hints_total: hints_total,
        hints_used: hints_used
      }
    end

    private

    def check_win(answer)
      return unless answer.eql?('++++')

      @status = :over
      @result = :win
    end

    def check_lose
      return unless @attempts_used >= attempts_total

      @status = :over
      @result = :lose
    end
  end
end
