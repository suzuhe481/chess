# Board object.
# Containing all of the pieces of the game.
class Board
  attr_accessor :curr_player, :opponent_player, :curr_team, :opponent_team

  def initialize
    @curr_player = "Player 1"
    @opponent_player = "Player 2"

    @curr_team = []
    # Player 1 Pawns
    @curr_team.append(Pawn.new("a", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("b", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("c", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("d", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("e", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("f", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("g", 2, "Player 1", "W_Pa"))
    @curr_team.append(Pawn.new("h", 2, "Player 1", "W_Pa"))
    # Player 1 Rooks
    @curr_team.append(Rook.new("a", 1, "Player 1", "W_Ro"))
    @curr_team.append(Rook.new("h", 1, "Player 1", "W_Ro"))
    # Player 1 Knights
    @curr_team.append(Knight.new("b", 1, "Player 1", "W_Kn"))
    @curr_team.append(Knight.new("g", 1, "Player 1", "W_Kn"))
    # Player 1 Bishops
    @curr_team.append(Bishop.new("c", 1, "Player 1", "W_Bi"))
    @curr_team.append(Bishop.new("f", 1, "Player 1", "W_Bi"))
    # Player 1 Queen and King
    @curr_team.append(Queen.new("d", 1, "Player 1", "W_Qu"))
    @curr_team.append(King.new("e", 1, "Player 1", "W_Ki"))
    

    @opponent_team = []
    # Player 2 Pawns
    @opponent_team.append(Pawn.new("a", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("b", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("c", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("d", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("e", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("f", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("g", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("h", 7, "Player 2", "B_Pa"))
    # Player 2 Rooks
    @opponent_team.append(Rook.new("a", 8, "Player 2", "B_Ro"))
    @opponent_team.append(Rook.new("h", 8, "Player 2", "B_Ro"))
    # Player 2 Knights
    @opponent_team.append(Knight.new("b", 8, "Player 2", "B_Kn"))
    @opponent_team.append(Knight.new("g", 8, "Player 1", "B_Kn"))
    # Player 2 Bishops
    @opponent_team.append(Bishop.new("c", 8, "Player 2", "B_Bi"))
    @opponent_team.append(Bishop.new("f", 8, "Player 2", "B_Bi"))
    # Player 2 Queen and King
    @opponent_team.append(Queen.new("d", 8, "Player 2", "B_Qu"))
    @opponent_team.append(King.new("e", 8, "Player 2", "B_Ki"))
  end

  # Returns an array of valid moves from a given piece's current position.
  def find_moves(chosen_piece)
    valid_moves = []

    chosen_piece.movement.each do |move|
      valid_moves.append(move) if check_valid_move?(move) && empty_space?(move)
    end

    valid_moves
  end

  # Returns true if a given position is a valid move.
  # Returns false otherwise.
  def check_valid_move?(move)
    file_pos_reg_exp = /^[a-h]$/
    rank_pos_reg_exp = /^[1-8]$/

    return true if move[0].match(file_pos_reg_exp) && move[1].to_s.match(rank_pos_reg_exp)

    return false
  end

  # Returns true if a move given is currently empty.
  # Returns false otherwise.
  def empty_space?(move)
    @curr_team.each { |piece| return false if piece.position == move }

    return true
  end

  # Returns the piece object at a given position.
  # Returns nil if the position is empty.
  def get_piece_at(position)
    @curr_team.each { |piece| return piece if piece.position == position }

    @opponent_team.each { |piece| return piece if piece.position == position }

    return nil
  end
end
