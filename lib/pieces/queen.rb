# This class is for the queen piece in chess.
# Queen movement: Can move horizontally, vertically, or diagonally in any direction for any number 
# of squares until the edge of the board.
# Capture: Can capture an opponent's piece by landing on it.
class Queen
  attr_accessor :rank, :file, :position

  def initialize(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
