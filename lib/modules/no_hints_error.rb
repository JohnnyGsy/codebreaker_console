# frozen_string_literal: true

module IcodebreakerGem
  class NoHintsError < StandardError
    def initialize(msg = 'No hints left.')
      super
    end
  end
end
