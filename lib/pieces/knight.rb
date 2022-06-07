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

  # Returns every valid or invalid move as an array from this piece's position.
  def movement
    all_moves = []

    all_moves.append( [(file.ord + 1).chr, rank + 2] )
    all_moves.append( [(file.ord + 1).chr, rank - 2] )
    all_moves.append( [(file.ord - 1).chr, rank - 2] )
    all_moves.append( [(file.ord - 1).chr, rank + 2] )
    all_moves.append( [(file.ord + 2).chr, rank + 1] )
    all_moves.append( [(file.ord + 2).chr, rank - 1] )
    all_moves.append( [(file.ord - 2).chr, rank - 1] )
    all_moves.append( [(file.ord - 2).chr, rank + 1] )

    all_moves
  end
end