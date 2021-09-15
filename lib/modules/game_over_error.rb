# frozen_string_literal: true

module IcodebreakerGem
  class GameOverError < StandardError
    def initialize(msg = 'The game is over.')
      super(msg)
    end
  end
 end
