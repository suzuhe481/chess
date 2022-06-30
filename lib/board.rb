# Board object.
# Containing all of the pieces of the game.
class Board
  attr_accessor :curr_player,  :curr_team, :curr_team_captures, 
                :opponent_player, :opponent_team, :opponent_team_captures

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
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  def find_moves(chosen_piece)
    return nil if chosen_piece.nil?

    return find_moves_for_curr_team(chosen_piece) if @curr_team.include?(get_piece_at(chosen_piece.position))
      
    return find_moves_for_opp_team(chosen_piece)
  end

  # Moves a given piece to the selected move from the movement_arr.
  # Params
  # piece: An object of either pawn, rook, knight, bishop, queen, or king.
  # move_choice: An integer.
  def move_piece_to(piece, move_choice)
    movement_arr = find_moves(piece)

    move = movement_arr[move_choice - 1]
    if piece.instance_of?(Pawn) && en_passant_capturable?(piece, move)
      capture = if piece.token[0] == "W"
                  [move[0], move[1] - 1]
                else
                  [move[0], move[1] + 1]
                end

      capture_piece_at(capture)
    elsif piece.instance_of?(King) && can_castle_to?(piece, move)
      rook = if (piece.position[0].ord - move[0].ord).positive?
               get_piece_at(["a", piece.position[1]])
             elsif (piece.position[0].ord - move[0].ord).negative?
               get_piece_at(["h", piece.position[1]])
             end

      rook_move = if (piece.position[0].ord - move[0].ord).positive?
                    ["d", piece.rank]
                  elsif (piece.position[0].ord - move[0].ord).negative?
                    ["f", piece.rank]
                  end

      rook.move_to(rook_move)
    else
      capture = move
    end

    capture_piece_at(capture)
    piece.move_to(move)
  end

  # Returns the piece object at a given position.
  # Returns nil if the position is empty.
  # Params
  # position: An array consiting of 2 elements, a single character from a-h, and a single integer from 1-8.
  def get_piece_at(position)
    @curr_team.each { |piece| return piece if piece.position == position }

    @opponent_team.each { |piece| return piece if piece.position == position }

    return nil
  end

  # For the current team, captures the piece at the given position.
  # Params
  # position: An array consiting of 2 elements, a single character from a-h, and a single integer from 1-8.
  def capture_piece_at(position)
    piece_to_capture = get_piece_at(position)

    return if piece_to_capture.nil?

    @curr_team_captures.append(piece_to_capture)

    @opponent_team = @opponent_team.reject { |piece| piece == piece_to_capture }
  end

  # Returns true if the current team's pawn is at the opposite end of the board.
  # Returns false otherwise.
  # Params
  # piece: An object of either pawn, rook, knight, bishop, queen, or king.
  def can_promote?(piece)
    return false unless piece.instance_of?(Pawn)

    return true if piece.rank == 8 || piece.rank == 1

    false
  end

  # Promotes a given pawn to the given type for the current player.
  # Params
  # pawn: A pawn object.
  # type: A string consister of 2 letters.
  def promote_pawn_to(pawn, type)
    return "Error. Can't promote piece." if pawn.rank != 8 && pawn.rank != 1

    pawn_pos = pawn.position
    pawn_owner = pawn.owner
    pawn_color = pawn.token[0]
    
    @curr_team = @curr_team.reject { |piece| piece == pawn }

    case type
    when 1
      @curr_team.append(Rook.new(pawn_pos[0], pawn_pos[1], pawn_owner, "#{pawn_color}_Ro"))
    when 2
      @curr_team.append(Knight.new(pawn_pos[0], pawn_pos[1], pawn_owner, "#{pawn_color}_Kn"))
    when 3
      @curr_team.append(Bishop.new(pawn_pos[0], pawn_pos[1], pawn_owner, "#{pawn_color}_Bi"))
    when 4
      @curr_team.append(Queen.new(pawn_pos[0], pawn_pos[1], pawn_owner, "#{pawn_color}_Qu"))
    when 5
      @curr_team.append(Pawn.new(pawn_pos[0], pawn_pos[1], pawn_owner, "#{pawn_color}_Pa"))
    else
      puts "Invalid piece type"
    end
  end

  # Switches the current and opponent player.
  def switch_player
    reset_opponent_en_passant

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

  # Returns true if a king placed at the given position would be in chekc.
  # Returns false otherwise.
  # Params
  # position: An array consiting of 2 elements, a single character from a-h, and a single integer from 1-8.
  def in_check_at?(position)
    @opponent_team.each do |piece|
      moves = find_moves(piece)

      moves.each do |move|
        return true if move == position
      end
    end

    return false
  end

  # Returns true if the current team's king is in checkmate.
  # Returns false otherwise.
  def in_checkmate?
    curr_king = @curr_team.detect { |piece| piece.class.to_s == "King" }

    king_moves = find_moves(curr_king)
    king_moves.unshift(curr_king.position)

    king_moves.each do |move|
      return false unless in_check_at?(move)
    end

    true
  end

  # Returns true if the current player is in a stalemate.
  # Returns false otherwise.
  def in_stalemate?
    return false if in_check?

    king = @curr_team.detect { |piece| piece.class.to_s == "King" }

    king_moves = find_moves(king)

    stalemate = false
    king_moves.each do |move|
      next if move == "back"

      stalemate = true if in_check_at?(move)
    end

    stalemate
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

  # Returns true if the given king can castle to the given move.
  # Returns false otherwise.
  # CASTLE CONDITIONS
  # King must not have moved.
  # Chosen rook must not have moved.
  # There must be empty space between the king and the chosen rook.
  # The king must not be in check.
  # The king must not travel through a check.
  # Params
  # king: A king object.
  # move: An array consiting of 2 elements, a single character from a-h, and a single integer from 1-8.
  def can_castle_to?(king, move)
    return false if king.first_move == false

    return false if move.nil?

    return false if move[0] == "d" || move[0] == "f"

    # Gets left or right, non-moved rook, depending on the move given.
    rook = if (king.position[0].ord - move[0].ord).positive? &&
              get_piece_at(["a", king.position[1]]).instance_of?(Rook) &&
              get_piece_at(["a", king.position[1]]).first_move == true

             get_piece_at(["a", king.position[1]])
           elsif (king.position[0].ord - move[0].ord).negative? &&
                 get_piece_at(["h", king.position[1]]).instance_of?(Rook) &&
                 get_piece_at(["h", king.position[1]]).first_move == true
             
             get_piece_at(["h", king.position[1]])
           else
             return false
           end

    # Stores an operator in a variable depending on if the left or right rook is picked.
    direction_operator = if rook.position[0] == "a"
                           :-
                         else
                           :+
                         end

    # Checks if king is in check when moved 2 spaces left or right.
    2.times do
      next_move = [(king.position[0].ord).public_send(direction_operator, 1).chr, king.position[1]]

      return false if !empty_space?(next_move) || in_check_at?(next_move)
    end

    return true
  end

  # Returns true is the user selection is valid.
  # Valid is...
  # A length of 2
  # Location is not on the board or
  # Location is empty or
  # Location is an opponent's piece.
  # Params
  # user_selection: A string.
  def validate_user_selection(user_selection)
    return false if user_selection.length != 2

    piece_location = [user_selection[0], user_selection[1].to_i]

    return false if !check_valid_move?(piece_location) ||
                    empty_space?(piece_location) ||
                    opponent_team?(piece_location)
                    
    return true
  end

  private

  # Places current team pieces on board.
  # Params
  # board_arr: An 8x8 2d array.
  def populate_curr_team(board_arr)
    @curr_team.each do |piece|
      piece_file = piece.file.ord - 96
      piece_rank = piece.rank

      board_arr[piece_file - 1][piece_rank - 1] = piece
    end

    board_arr
  end

  # Places opponent team pieces on board.
  # Params
  # board_arr: An 8x8 2d array.
  def populate_opponent_team(board_arr)
    @opponent_team.each do |piece|
      piece_file = piece.file.ord - 96
      piece_rank = piece.rank

      board_arr[piece_file - 1][piece_rank - 1] = piece
    end
    
    board_arr
  end

  # Displays the board.
  # Params
  # board_arr: An 8x8 2d array.
  # empty_token: A string consiting of 4 blank spaces.
  def display_board(board_arr, empty_token)
    nums_enum = (1..8).reverse_each
    
    puts "    _______________________________________________________"
    board_arr.each do |row|
      
      print "   |"
      row.each do |piece|
        if piece == empty_token
          print "      |"
        else
          print "     #{piece.selected}|"
        end
      end
      puts

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

    print "   "
    ("a".."h").each do |letter|
      print "   "
      print letter
      print "   "
    end
    puts
  end

  # Returns true if a given position is a valid move.
  # Returns false otherwise.
  # Params
  # move: An array consisting of 2 elements.
  def check_valid_move?(move)
    file_pos_reg_exp = /^[a-h]$/
    rank_pos_reg_exp = /^[1-8]$/

    return true if move[0].match(file_pos_reg_exp) && move[1].to_s.match(rank_pos_reg_exp)

    return false
  end

  # Returns true if a move given is currently empty.
  # Returns false otherwise.
  # Params
  # move: An array consisting of 2 elements.
  def empty_space?(move)
    empty = true
    
    @curr_team.each { |piece| empty = false if piece.position == move }
    @opponent_team.each { |piece| empty = false if piece.position == move }

    return empty
  end

  # Returns true if the move given currently has a piece from the same team.
  # Returns false otherwise.
  # Params
  # move: An array consisting of 2 elements.
  def same_team?(move)
    @curr_team.each { |piece| return true if piece.position == move }

    return false
  end

  # Returns true if the move given currently has a piece from the opponent's team.
  # Returns false otherwise.
  # Params
  # move: An array consisting of 2 elements.
  def opponent_team?(move)
    @opponent_team.each { |piece| return true if piece.position == move }

    return false
  end

  # Helper function for #find_moves
  # Finds valid moves if the chosen piece is for the current team.
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  def find_moves_for_curr_team(chosen_piece)
    valid_moves = []

    chosen_piece.movement.each_with_index do |move_direction, index|
      move_direction.each do |move|
        if check_valid_move?(move)
          break if same_team?(move)

          # For pawns.
          if chosen_piece.instance_of?(Pawn)
            valid_moves.append(move) if valid_pawn_move_curr_team?(chosen_piece, move, index)
          # For kings.
          elsif chosen_piece.instance_of?(King)
            valid_moves.append(move) if valid_king_move_curr_team?(chosen_piece, move, index)
          # For all other pieces.
          else
            valid_moves.append(move) if empty_space?(move)

            if opponent_team?(move)
              valid_moves.append(move)
              break
            end
          end
        end
      end
    end

    valid_moves.append("back")
    valid_moves
  end

  # Helper function for #find_moves_for_curr_team
  # Checks if a king's move is valid.
  # KING NOTES
  # Index = 8: A Castle move
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  # move: An array consisting of 2 elements.
  # index: An integer.
  def valid_king_move_curr_team?(chosen_piece, move, index)
    if index == 8
      return true if can_castle_to?(chosen_piece, move)
    else
      return true if empty_space?(move) && !in_check_at?(move)

      return true if opponent_team?(move) && !in_check_at?(move)
    end

    return false
  end

  # Helper function for #find_moves_for_curr_team
  # Returns true if the given piece can move to given move.
  # PAWN NOTES
  # Index = 0: Vertical movement
  # Index = 1 or 2: Diagonal movement
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  # move: An array consisting of 2 elements.
  # index: An integer.
  def valid_pawn_move_curr_team?(chosen_piece, move, index)
    diagonal_index = [1, 2]

    return true if empty_space?(move) && index == 0

    return true if opponent_team?(move) && diagonal_index.include?(index)

    return true if en_passant_capturable?(chosen_piece, move) && diagonal_index.include?(index)

    return false
  end

  # Helper function for #find_moves
  # Finds valid moves if the chosen piece is for the opponent's team.
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  def find_moves_for_opp_team(chosen_piece)
    valid_moves = []

    chosen_piece.movement.each_with_index do |move_direction, index|
      move_direction.each do |move|
        if check_valid_move?(move)
          break if opponent_team?(move)

          # For pawns.
          if chosen_piece.instance_of?(Pawn)
            valid_moves.append(move) if valid_pawn_move_opp_team?(chosen_piece, move, index)
          # For all other pieces.
          else
            valid_moves.append(move) if empty_space?(move)

            if same_team?(move)
              valid_moves.append(move)
              break
            end
          end
        end
      end
    end

    valid_moves.append("back")
    valid_moves
  end

  # Helper function for #find_moves_for_opp_team
  # Returns true if the given piece can move to given move.
  # PAWN NOTES
  # Index = 0: Vertical movement
  # Index = 1 or 2: Diagonal movement
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  # move: An array consisting of 2 elements.
  # index: An integer.
  def valid_pawn_move_opp_team?(chosen_piece, move, index)
    diagonal_index = [1, 2]

    return true if empty_space?(move) && index == 0

    return true if opponent_team?(move) && diagonal_index.include?(index)

    return true if en_passant_capturable?(chosen_piece, move) && diagonal_index.include?(index)

    return false
  end

  # Returns true if the chosen piece can go to given move via en passant.
  # Returns false otherwise.
  # Params
  # chosen_piece: An object of either pawn, rook, knight, bishop, queen, or king.
  # move: An array consisting of 2 elements.
  def en_passant_capturable?(chosen_piece, move)
    left_file = (chosen_piece.file.ord - 1).chr
    right_file = (chosen_piece.file.ord + 1).chr

    piece_left_of = get_piece_at([left_file, chosen_piece.rank])
    piece_right_of = get_piece_at([right_file, chosen_piece.rank])

    return true if piece_left_of.instance_of?(Pawn) && 
                   piece_left_of.en_passant_capturable == true && 
                   move[0] == piece_left_of.file

    return true if piece_right_of.instance_of?(Pawn) && 
                   piece_right_of.en_passant_capturable == true && 
                   move[0] == piece_right_of.file

    return false
  end

  # Makes all of the opponent's pawns' en_passant_capturable variables equal to false.
  # MUST BE RUN AT THE END OF EVERY TURN.
  def reset_opponent_en_passant
    @opponent_team = @opponent_team.each { |piece| piece.en_passant_capturable = false if piece.instance_of?(Pawn) }
  end
end
