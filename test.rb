# frozen_string_literal: true

require_relative 'config1'

game = IcodebreakerGem::Game.new('Van', :hell)
puts game.attempt(5643.to_s)
puts game.attempt('6411')
puts game.attempt('6544')
puts game.attempt('4321')
puts game.attempt('4321')
puts game.attempt('4321')

puts game.attempts_total

puts game.game_data

game.load
game.save(game.game_data)
