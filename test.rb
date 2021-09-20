require_relative 'config1.rb'

game = IcodebreakerGem::Game.new("Van",:hell)

puts game.attempt(1234.to_s)
puts game.attempt("4321")
puts game.attempt("4321")
puts game.attempt("4321")
game.check_win

puts game.attempts_total
puts game.hint
puts game.game_data
puts game.rating
def statistics(**stats)



end