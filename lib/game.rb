# Game Object.
# Containing the board and relaying instructions to the player.
class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def start; end
end
