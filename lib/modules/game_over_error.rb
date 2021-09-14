# frozen_string_literal: true

module IcodebreakerGem
  module Validation
    class GameOverError < StandardError
      def initialize(message = 'The game is over.')
        super
      end
    end
  end
end
