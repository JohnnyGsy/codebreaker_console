# frozen_string_literal: true

module IcodebreakerGem
  module Validation
    class NoHintsError < StandardError
      def initialize(message = 'No hints left.')
        super
      end
    end
  end
end
