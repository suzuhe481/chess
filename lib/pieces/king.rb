# The king piece in chess.
# King movement: Can move horizontally, vertically, or diagonally in any direction for only 1 square 
# until the edge of the board.
# Capture: Can capture an opponent's piece when landing on it.
class King
  attr_accessor :rank, :file, :position, :in_check, :owner, :token

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @in_check = false
    @owner = owner
    @token = token
  end

  # Returns every valid or invalid move as an array from this piece's position.
  def movement
    all_moves = []

    all_moves.append( [(file.ord + 1).chr, rank] )
    all_moves.append( [(file.ord - 1).chr, rank] )
    all_moves.append( [(file.ord).chr, rank + 1] )
    all_moves.append( [(file.ord).chr, rank - 1] )

    all_moves.append( [(file.ord + 1).chr, rank + 1] )
    all_moves.append( [(file.ord - 1).chr, rank - 1] )
    all_moves.append( [(file.ord + 1).chr, rank - 1] )
    all_moves.append( [(file.ord - 1).chr, rank + 1] )

    all_moves
  end
end
