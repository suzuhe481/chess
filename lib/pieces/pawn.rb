# This class is for the pawn piece in chess.
# Pawn movement: Moves 1 square forward at a time. Can move 2 squares forward only on that piece's first turn.
# Capture: Can capture an opponent's piece if it is 1 square away, diagonally, to the right or left.
class Pawn
  attr_accessor :rank, :file, :position, :first_move, :owner, :token, :en_passant_capturable, :selected

  def initialize(file, rank, owner, token)
    @file = file
    @rank = rank
    @position = [file, rank]
    @first_move = true
    @owner = owner
    @token = token
    @en_passant_capturable = false
    @selected = " "
  end

  # Returns a 2D array of every valid or invalid move from this piece's position.
  # Each array in the 2D array is a separate direction.
  def movement
    all_moves = []
    moves_forward = []
    moves_diagonal_1 = []
    moves_diagonal_2 = []

    if @token[0] == "W"
      moves_forward.append( [(file.ord).chr, rank + 1] )
      moves_forward.append( [(file.ord).chr, rank + 2] ) if @first_move == true
      moves_diagonal_1.append( [(file.ord + 1).chr, rank + 1] )
      moves_diagonal_2.append( [(file.ord - 1).chr, rank + 1] )
    else
      moves_forward.append( [(file.ord).chr, rank - 1] )
      moves_forward.append( [(file.ord).chr, rank - 2] ) if @first_move == true
      moves_diagonal_1.append( [(file.ord + 1).chr, rank - 1] )
      moves_diagonal_2.append( [(file.ord - 1).chr, rank - 1] )
    end

    all_moves.append(moves_forward)
    all_moves.append(moves_diagonal_1)
    all_moves.append(moves_diagonal_2)

    all_moves
  end

  # Changes this pieces current position.
  def move_to(position)
    if @first_move == true && (position[1] == @rank + 2 || position[1] == @rank - 2)
      @en_passant_capturable = true
    end

    @file = position[0]
    @rank = position[1]
    @position = position

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
