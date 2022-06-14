# Board object.
# Containing all of the pieces of the game.
class Board
  attr_accessor :curr_player, :opponent_player, :curr_team, :opponent_team, :curr_team_captures, :opponent_team_captures

  def initialize
    @curr_player = "Player 1"
    @opponent_player = "Player 2"

    @curr_team = []
    @curr_team_captures = []
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
    @opponent_team_captures = []
    # # Player 2 Pawns
    @opponent_team.append(Pawn.new("a", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("b", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("c", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("d", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("e", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("f", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("g", 7, "Player 2", "B_Pa"))
    @opponent_team.append(Pawn.new("h", 7, "Player 2", "B_Pa"))
    # # Player 2 Rooks
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

  # Returns a sorted array of valid moves from a given piece's current position.
  def find_moves(chosen_piece)
    return find_moves_for_curr_team(chosen_piece) if @curr_team.include?(get_piece_at(chosen_piece.position))
      
    return find_moves_for_opp_team(chosen_piece)
  end

  # Helper function for find_moves
  # Finds valid moves if the chosen piece is for the current team.
  def find_moves_for_curr_team(chosen_piece)
    valid_moves = []
    chosen_piece.movement.each do |move_direction|
      move_direction.each do |move|
        if check_valid_move?(move)
          break if same_team?(move)

          valid_moves.append(move) if empty_space?(move)

          if opponent_team?(move)
            valid_moves.append(move)
            break
          end
        end
      end
    end
    valid_moves
  end

  # Helper function for find_moves
  # Finds valid moves if the chosen piece is for the opponent's team.
  def find_moves_for_opp_team(chosen_piece)
    valid_moves = []
    chosen_piece.movement.each do |move_direction|
      move_direction.each do |move|
        if check_valid_move?(move)
          break if opponent_team?(move)

          valid_moves.append(move) if empty_space?(move)

          if same_team?(move)
            valid_moves.append(move)
            break
          end
        end
      end
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
    empty = true
    
    @curr_team.each { |piece| empty = false if piece.position == move }
    @opponent_team.each { |piece| empty = false if piece.position == move }

    return empty
  end

  # Returns true if the move given currently has a piece from the same team.
  # Returns false otherwise.
  def same_team?(move)
    @curr_team.each { |piece| return true if piece.position == move }

    return false
  end

  # Returns true if the move given currently has a piece from the opponent's team.
  # Returns false otherwise.
  def opponent_team?(move)
    @opponent_team.each { |piece| return true if piece.position == move }

    return false
  end

  # Returns the piece object at a given position.
  # Returns nil if the position is empty.
  def get_piece_at(position)
    @curr_team.each { |piece| return piece if piece.position == position }

    @opponent_team.each { |piece| return piece if piece.position == position }

    return nil
  end

  # For the current team, captures the piece at the given position.
  def capture_piece_at(position)
    piece_to_capture = get_piece_at(position)

    @curr_team_captures.append(piece_to_capture)

    @opponent_team = @opponent_team.reject { |piece| piece == piece_to_capture}
  end

  # Switches the current and opponent player.
  def switch_player
    temp_player = @curr_player
    @curr_player = @opponent_player
    @opponent_player = temp_player

    temp_team = @curr_team
    @curr_team = @opponent_team
    @opponent_team = temp_team

    temp_capture = @curr_team_captures
    @curr_team_captures = @opponent_team_captures
    @opponent_team_captures = temp_capture
  end

  # Returns true if the current team's king is in check.
  # Returns false otherwise.
  def in_check?
    king_position = @curr_team.detect { |piece| piece.class.to_s == "King" }.position

    @opponent_team.each do |piece|
      moves = find_moves(piece)

      moves.each do |move|
        return true if move == king_position
      end
    end

    false
  end

  # Returns true if the current team's king is in checkmate.
  # Returns false otherwise.
  def in_checkmate?
    curr_king = @curr_team.detect { |piece| piece.class.to_s == "King" }
    original_position = curr_king.position

    king_moves = find_moves(curr_king)
    king_moves.unshift(curr_king.position)
    p king_moves

    king_moves.each do |move|
      curr_king.move_to(move[0], move[1])
      print_board

      curr_king.move_to(original_position[0], original_position[1])
      return false unless in_check?
    end

    curr_king.move_to(original_position[0], original_position[1])
    true
  end



  # Prints the current board.
  def print_board
    # Sideways board
    board_arr = Array.new(8) { Array.new(8) }
    empty_token = "    "

    # Placing empty spaces.
    board_arr.each_with_index do |file, file_index|
      file.each_with_index do |_rank, rank_index|
        board_arr[file_index][rank_index] = empty_token
      end
    end

    board_arr = populate_curr_team(board_arr)
    board_arr = populate_opponent_team(board_arr)

    # Rotates the board.
    board_arr = board_arr.map(&:reverse).transpose

    display_board(board_arr, empty_token)
  end

  private

  # Places current team pieces on board.
  def populate_curr_team(board_arr)
    @curr_team.each do |piece|
      piece_file = piece.file.ord - 96
      piece_rank = piece.rank

      board_arr[piece_file - 1][piece_rank - 1] = piece
    end

    board_arr
  end

  # Places opponent team pieces on board.
  def populate_opponent_team(board_arr)
    @opponent_team.each do |piece|
      piece_file = piece.file.ord - 96
      piece_rank = piece.rank

      board_arr[piece_file - 1][piece_rank - 1] = piece
    end
    
    board_arr
  end

  # Displays the board.
  def display_board(board_arr, empty_token)
    nums_enum = (1..8).reverse_each
    
    puts "    _______________________________________________________"
    board_arr.each do |row|
      puts "   |      |      |      |      |      |      |      |      |"

      row_num = nums_enum.next
      print " #{row_num} "
      row.each do |piece|
        if piece == empty_token
          print "|  #{piece}"
        else
          print "| #{piece.token} "
        end
      end
      print "|"
      puts

      print "   |______|______|______|______|______|______|______|______|"
      puts
    end

    letters = ("a".."h")
    print "   "
    letters.each do |letter|
      print "   "
      print letter
      print "   "
    end
    puts
  end
end
