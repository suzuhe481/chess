# This class is for the bishop piece in chess.
# Bishop movement: This piece can move digonally in any direction until the edge of the board.
# Capture: Can capture an opponent's piece when landing on it.
class Bishop
  attr_accessor :rank, :file, :position, :owner, :token, :selected

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @owner = owner
    @token = token
    @selected = " "
  end

  # Returns a 2D array of every valid or invalid move from this piece's position.
  # Each array in the 2D array is a separate direction.
  def movement
    all_moves = []
    moves_NW = []
    moves_NE = []
    moves_SW = []
    moves_SE = []
    max_range = (1..7)

    max_range.each do |spaces|
      moves_NW.append([(file.ord - spaces).chr, rank + spaces])
      moves_NE.append([(file.ord + spaces).chr, rank + spaces])
      moves_SW.append([(file.ord - spaces).chr, rank - spaces])
      moves_SE.append([(file.ord + spaces).chr, rank - spaces])
    end

    all_moves.append(moves_NW)
    all_moves.append(moves_NE)
    all_moves.append(moves_SW)
    all_moves.append(moves_SE)

    all_moves
  end

  # Changes this pieces current position.
  def move_to(position)
    @file = position[0]
    @rank = position[1]
    @position = [position[0], position[1]]
  end

  # Selects a piece by making @selected an "*"
  def select
    @selected = "*"
  end

  # Deselects a piece by making @selected a single space.
  def deselect
    @selected = " "
  end
end
