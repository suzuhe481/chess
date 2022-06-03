# This class is for the pawn piece in chess.
# Pawn movement: Moves 1 square forward at a time. Can move 2 squares forward only on that piece's first turn.
# Capture: Can capture an opponent's piece if it is 1 square away, diagonally, to the right or left.
class Pawn
  attr_accessor :rank, :file, :position, :first_move

  def initialize(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
    @first_move = true
  end
end
