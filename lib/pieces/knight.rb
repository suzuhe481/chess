# The class for a knight piece in chess.
# Knight movement: Moves in an L-shape where it moves 2 squares vertically and 1 square horizontally, or
#                  2 squares horizontally and 1 square vertically.
#                  This piece is allowed to jump over other pieces.
# Capture: Can capture a opponent's piece if it lands on it.
class Knight
  attr_accessor :rank, :file, :position

  def initialize(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
