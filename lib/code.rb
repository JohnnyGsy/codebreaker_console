# frozen_string_literal: true

class Code
  include Validation

  attr_reader :secret

  def initialize(secret = Code.random)
    validate_code secret

    @secret = secret.to_s
    @shuffle = @secret.each_char.to_a.shuffle
    @hint_idx = 0
  end

  def compare(guess)
    return '++++' if @secret == guess
    return '' if (@secret.each_char.to_a & guess.each_char.to_a).empty?

    bulls1, cows1 = bulls_and_cows(@secret, guess)
    bulls2, cows2 = bulls_and_cows(guess, @secret)

    '+' * [bulls1, bulls2].min + '-' * [cows1, cows2].min
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

  def bulls_and_cows(word1, word2)
    bulls = cows = 0
    word1.each_char.to_a.each_index do |index|
      if word2[index] == word1[index]
        bulls += 1
      elsif word2.include? word1[index]
        cows += 1
      end
    end
    [bulls, cows]
  end
end
