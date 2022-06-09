# This class is for the pawn piece in chess.
# Pawn movement: Moves 1 square forward at a time. Can move 2 squares forward only on that piece's first turn.
# Capture: Can capture an opponent's piece if it is 1 square away, diagonally, to the right or left.
class Pawn
  attr_accessor :rank, :file, :position, :first_move, :owner, :token

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @first_move = true
    @owner = owner
    @token = token
  end

  # Returns a 2D array of every valid or invalid move from this piece's position.
  # Each array in the 2D array is a separate direction.
  def movement
    all_moves = []
    moves_up = []

    moves_up.append( [(file.ord).chr, rank + 1] )
    moves_up.append( [(file.ord).chr, rank + 2] ) if @first_move == true

    all_moves.append(moves_up)

    all_moves
  end

  # Changes this pieces current position.
  def move_to(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
