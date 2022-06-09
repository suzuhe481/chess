# This class is for the rook piece in chess.
# Rook movement: Can move vertically or horizontally for any number of squares until the edge of the board.
# Capture: Can capture an opponent's piece by landing on it.
class Rook
  attr_accessor :rank, :file, :position, :owner, :token

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @owner = owner
    @token = token
  end

  # Returns a 2D array of every valid or invalid move from this piece's position.
  # Each array in the 2D array is a separate direction.
  def movement
    all_moves = []
    moves_up = []
    moves_down = []
    moves_left = []
    moves_right = []
    max_range = (1..7)

    max_range.each do |spaces|
      moves_up.append([(file.ord).chr, rank + spaces])
      moves_down.append([(file.ord).chr, rank - spaces])
      moves_left.append([(file.ord - spaces).chr, rank])
      moves_right.append([(file.ord + spaces).chr, rank])
    end

    all_moves.append(moves_up)
    all_moves.append(moves_down)
    all_moves.append(moves_left)
    all_moves.append(moves_right)

    all_moves
  end

  # Changes this pieces current position.
  def move_to(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
