# The king piece in chess.
# King movement: Can move horizontally, vertically, or diagonally in any direction for only 1 square 
# until the edge of the board.
# Capture: Can capture an opponent's piece when landing on it.
class King
  attr_accessor :rank, :file, :position, :in_check

  def initialize(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
    @in_check = false
  end
end
