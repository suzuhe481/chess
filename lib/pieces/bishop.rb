# This class is for the bishop piece in chess.
# Bishop movement: This piece can move digonally in any direction until the edge of the board.
# Capture: Can capture an opponent's piece when landing on it.
class Bishop
  attr_accessor :rank, :file, :position, :owner, :token

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @owner = owner
    @token = token
  end

  # Returns every valid or invalid move as an array from this piece's position.
  def movement
    all_moves = []
    max_range = (1..7)

    max_range.each do |spaces|
      all_moves.append( [(file.ord + spaces).chr, rank + spaces] )
      all_moves.append( [(file.ord - spaces).chr, rank - spaces] )
      all_moves.append( [(file.ord + spaces).chr, rank - spaces] )
      all_moves.append( [(file.ord - spaces).chr, rank + spaces] )
    end

    all_moves
  end
end
