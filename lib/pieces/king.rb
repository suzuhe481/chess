# The king piece in chess.
# King movement: Can move horizontally, vertically, or diagonally in any direction for only 1 square 
# until the edge of the board.
# Capture: Can capture an opponent's piece when landing on it.
class King
  attr_accessor :rank, :file, :position, :first_move, :in_check, :owner, :token, :selected

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @first_move = true
    @in_check = false
    @owner = owner
    @token = token
    @selected = " "
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
    moves_castle = []

    moves_up.append([(file.ord).chr, rank + 1])
    moves_down.append([(file.ord).chr, rank - 1])
    moves_left.append([(file.ord - 1).chr, rank])
    moves_right.append([(file.ord + 1).chr, rank])

    moves_NW.append([(file.ord - 1).chr, rank + 1])
    moves_NE.append([(file.ord + 1).chr, rank + 1])
    moves_SW.append([(file.ord - 1).chr, rank - 1])
    moves_SE.append([(file.ord + 1).chr, rank - 1])

    moves_castle.append([(file.ord - 2).chr, rank]) if first_move == true
    moves_castle.append([(file.ord + 2).chr, rank]) if first_move == true

    all_moves.append(moves_up)
    all_moves.append(moves_down)
    all_moves.append(moves_left)
    all_moves.append(moves_right)
    all_moves.append(moves_NW)
    all_moves.append(moves_NE)
    all_moves.append(moves_SW)
    all_moves.append(moves_SE)
    all_moves.append(moves_castle)

    all_moves
  end

  # Changes this pieces current position.
  def move_to(position)
    @file = position[0]
    @rank = position[1]
    @position = [position[0], position[1]]

    @first_move = false
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
