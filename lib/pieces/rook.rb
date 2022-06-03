# This class is for the rook piece in chess.
# Rook movement: Can move vertically or horizontally for any number of squares until the edge of the board.
# Capture: Can capture an opponent's piece by landing on it.
class Rook
  attr_accessor :rank, :file, :position

  def initialize(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
