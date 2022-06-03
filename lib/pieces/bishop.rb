# This class is for the bishop piece in chess.
# Bishop movement: This piece can move digonally in any direction until the edge of the board.
# Capture: Can capture an opponent's piece when landing on it.
class Bishop
  attr_accessor :rank, :file, :position

  def initialize(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
