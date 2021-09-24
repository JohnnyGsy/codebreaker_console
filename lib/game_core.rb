# frozen_string_literal: true

module IcodebreakerGem
  class GameCore
    include Validation

    attr_reader :secret

    def initialize(secret)
      validate_code secret

      @secret = secret.to_s
      @shuffle = @secret.each_char.to_a.shuffle
      @hint_idx = 0
    end

    def compare(guess)
      return '++++' if @secret == guess
      return '' if (@secret.each_char.to_a & guess.each_char.to_a).empty?

      pluses1, minuses1 = pluses_and_minuses(@secret, guess)

      pluses2, minuses2 = pluses_and_minuses(guess, @secret)

      '+' * [pluses1, pluses2].min + '-' * [minuses1, minuses2].min
    end

    def hint
      result = @shuffle[@hint_idx]
      @hint_idx += 1
      @hint_idx = 0 if @hint_idx >= @shuffle.size
      result
    end

    def self.random
      (0..3).map { rand(1..6) }.map(&:to_s).join
    end

    private

    def pluses_and_minuses(word1, word2)
      pluses = minuses = 0
      word1.each_char.to_a.each_index do |index|
        if word2[index] == word1[index]
          pluses += 1
        elsif word2.include? word1[index]
          minuses += 1
        end
      end
      [pluses, minuses]
    end
  end
end
