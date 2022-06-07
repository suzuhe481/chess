# Board object.
# Containing all of the pieces of the game.
class Board
  attr_accessor :pawn, :knight
  attr_accessor :pawn, :knight, :bishop, :rook, :queen, :king, :curr_player, :opponent_player, :curr_team, :opponent_team

  def initialize; end
  def initialize
    @curr_player = "Player 1"
    @opponent_player = "Player 2"

    @knight = Knight.new("b", 1)
    @pawn = Pawn.new("a", 2)
    @bishop = Bishop.new("c", 1)
    @rook = Rook.new("a", 1)
    @queen = Queen.new("d", 1)
    @king = King.new("e", 1)
  end

  # Returns an array of valid moves from a given piece's current position.
  def find_moves(chosen_piece)
    valid_moves = []

    chosen_piece.movement.each do |move|
      valid_moves.append(move) if check_valid_move(move)
    end

    valid_moves
  end

  # Returns true if a given position is a valid move.
  # Returns false otherwise.
  def check_valid_move(move)
    file_pos_reg_exp = /^[a-h]$/
    rank_pos_reg_exp = /^[1-8]$/

    return true if move[0].match(file_pos_reg_exp) && move[1].to_s.match(rank_pos_reg_exp)

    return false
  end
end