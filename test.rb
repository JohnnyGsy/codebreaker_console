# frozen_string_literal: true

require_relative 'config1'

game = IcodebreakerGem::Game.new('Van', :medium)
puts game.attempt(5643.to_s)
puts game.attempt('6411')
puts game.attempt('6544')
puts game.attempt('4321')
puts game.attempt('4321')
puts game.attempt('4321')

puts game.attempts_total

game.load_storage

game.sort_codebreakers
