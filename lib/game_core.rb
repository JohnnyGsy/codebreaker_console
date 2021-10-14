# frozen_string_literal: true

module IcodebreakerGem
  class GameCore
    include Validation
    attr_reader :secret

    def initialize(secret)
      validate_code secret

      @secret = secret.to_s
      @shuffle = @secret.chars.shuffle
    end

    def compare(guess)
      return '++++' if @secret == guess
      return '' if (@secret.chars & guess.chars).empty?

      pluses1, minuses1 = pluses_and_minuses(@secret, guess)

      pluses2, minuses2 = pluses_and_minuses(guess, @secret)

      '+' * [pluses1, pluses2].min + '-' * [minuses1, minuses2].min
    end
    
    def hint
      @shuffle.pop
    end

    def self.random
      (0..3).map { rand(1..6) }.join
    end

    private

    def pluses_and_minuses(guess_secret, secret_guess)
      pluses = minuses = 0
      guess_secret.chars.each_index do |index|
        if secret_guess[index] == guess_secret[index]
          pluses += 1
        elsif secret_guess.include? guess_secret[index]
          minuses += 1
        end
      end
      [pluses, minuses]
    end
  end
end
