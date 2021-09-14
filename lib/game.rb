# frozen_string_literal: true

class Game
  include Validation

  STATUS = %i[go_on over].freeze
  OUTCOME = %i[win lose].freeze
  DIFFICULTIES = {
    easy: {
      score: 200,
      attempts_total: 15,
      hints_total: 2
    },
    medium: {
      score: 400,
      attempts_total: 10,
      hints_total: 1
    },
    hell: {
      score: 600,
      attempts_total: 5,
      hints_total: 1
    }
  }.freeze

  attr_reader :name, :difficulty, :attempts_used, :hints_used, :status, :outcome

  def initialize(name = 'User1', difficulty = :easy, secret = Code.random)
    validate_name name
    validate_difficulty difficulty

    @name = name.to_s
    @difficulty = difficulty.to_sym

    @attempts_used = 0
    @hints_used = 0

    @status = :go_on
    @outcome = nil

    @code = Code.new(secret)
  end

  def attempts_total
    Game::DIFFICULTIES[difficulty][:attempts_total]
  end

  def hints_total
    Game::DIFFICULTIES[difficulty][:hints_total]
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
      raise GameOverError
    end
  end

  def hint
    case @status
    when :go_on
      raise NoHintsError if @hints_used >= hints_total

      @hints_used += 1
      @code.hint
    when :over
      raise GameOverError
    end
  end

  def game_data
    {
      rating: rating,
      name: name,
      difficulty: difficulty.to_s,
      attempts_total: attempts_total,
      attempts_used: attempts_used,
      hints_total: hints_total,
      hints_used: hints_used
    }
  end

  def rating
    case outcome
    when :win
      DIFFICULTIES[difficulty][:score] - 10 * attempts_used - hints_used
    else
      0
    end
  end

  private

  def check_win(answer)
    return unless answer.eql?('++++')

    @status = :over
    @outcome = :win
  end

  def check_lose
    return unless @attempts_used >= attempts_total

    @status = :over
    @outcome = :lose
  end
end
