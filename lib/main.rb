require_relative "game.rb"
require_relative "board.rb"
Dir["./lib/pieces/*.rb"].sort.each { |file| require file }

game = Game.new
game.start
