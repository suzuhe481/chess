# Board object.
# Containing all of the pieces of the game.
class Board
  attr_accessor :curr_player, :opponent_player, :curr_team, :opponent_team

  def initialize
    @curr_player = "Player 1"
    @opponent_player = "Player 2"

    @curr_team = []
    @curr_team.append(Knight.new("b", 1, "Player 1", "W_Kn"))
    @curr_team.append(Pawn.new("a", 2, "Player 1", "W_Pa"))
    @curr_team.append(Bishop.new("c", 1, "Player 1", "W_Bi"))
    @curr_team.append(Rook.new("a", 1, "Player 1", "W_Ro"))
    @curr_team.append(Queen.new("d", 1, "Player 1", "W_Qu"))
    @curr_team.append(King.new("e", 1, "Player 1", "W_Ki"))
    
    @opponent_team = []
    @opponent_team.append(Knight.new("b", 1, "Player 1", "W_Kn"))
    @opponent_team.append(Pawn.new("a", 2, "Player 1", "W_Pa"))
    @opponent_team.append(Bishop.new("c", 1, "Player 1", "W_Bi"))
    @opponent_team.append(Rook.new("a", 1, "Player 1", "W_Ro"))
    @opponent_team.append(Queen.new("d", 1, "Player 1", "W_Qu"))
    @opponent_team.append(King.new("e", 1, "Player 1", "W_Ki"))
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
