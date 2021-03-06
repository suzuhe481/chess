# The class for a knight piece in chess.
# Knight movement: Moves in an L-shape where it moves 2 squares vertically and 1 square horizontally, or
#                  2 squares horizontally and 1 square vertically.
#                  This piece is allowed to jump over other pieces.
# Capture: Can capture a opponent's piece if it lands on it.
class Knight
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

    all_moves.append([ [(file.ord + 1).chr, rank + 2] ])
    all_moves.append([ [(file.ord + 1).chr, rank - 2] ])
    all_moves.append([ [(file.ord - 1).chr, rank - 2] ])
    all_moves.append([ [(file.ord - 1).chr, rank + 2] ])
    all_moves.append([ [(file.ord + 2).chr, rank + 1] ])
    all_moves.append([ [(file.ord + 2).chr, rank - 1] ])
    all_moves.append([ [(file.ord - 2).chr, rank - 1] ])
    all_moves.append([ [(file.ord - 2).chr, rank + 1] ])

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
