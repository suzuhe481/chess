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

  # Returns every valid or invalid move as an array from this piece's position.
  def movement
    all_moves = []
    max_range = (1..7)

    max_range.each do |spaces|
      all_moves.append( [(file.ord + spaces).chr, rank] )
      all_moves.append( [(file.ord - spaces).chr, rank] )
      all_moves.append( [(file.ord).chr, rank + spaces] )
      all_moves.append( [(file.ord).chr, rank - spaces] )
    end

    all_moves
  end
end
