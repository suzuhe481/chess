# This class is for the queen piece in chess.
# Queen movement: Can move horizontally, vertically, or diagonally in any direction for any number 
# of squares until the edge of the board.
# Capture: Can capture an opponent's piece by landing on it.
class Queen
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
    moves_NW = []
    moves_NE = []
    moves_SW = []
    moves_SE = []

    max_range = (1..7)
    max_range.each do |spaces|
      moves_up.append([(file.ord).chr, rank + spaces])
      moves_down.append([(file.ord).chr, rank - spaces])
      moves_left.append([(file.ord - spaces).chr, rank])
      moves_right.append([(file.ord + spaces).chr, rank])

      moves_NW.append([(file.ord - spaces).chr, rank + spaces])
      moves_NE.append([(file.ord + spaces).chr, rank + spaces])
      moves_SW.append([(file.ord - spaces).chr, rank - spaces])
      moves_SE.append([(file.ord + spaces).chr, rank - spaces])
    end

    all_moves.append(moves_up)
    all_moves.append(moves_down)
    all_moves.append(moves_left)
    all_moves.append(moves_right)
    all_moves.append(moves_NW)
    all_moves.append(moves_NE)
    all_moves.append(moves_SW)
    all_moves.append(moves_SE)

    all_moves
  end

  # Changes this pieces current position.
  def move_to(file, rank)
    @file = file
    @rank = rank
    @position = [file, rank]
  end
end
