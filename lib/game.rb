# Game Object.
# Containing the board and relaying instructions to the player.
class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  # Starts the introduction.
  def start
    input = nil

    loop do
      puts "Welcome to Chess. Player 1 will move first."
      puts "There is no computer opponent, so you need two human players to play this game."
      puts "[1] Start Game"
      puts "[2] Instructions"

      input = gets.chomp

      case input
      when "1"
        break
      when "2"
        print_help
      end
    end
    puts
    puts

    start_game
  end

  # Prints chess instructions.
  def print_help
    puts "=====Selecting a Piece====="
    puts "To select a piece enter the letter and number combination that your piece is located."
    puts "eg."
    puts "a2, c7, d8"
    puts "After selecting a piece, it will be highlighted with an asterisk * in the corner so you know which piece you picked."
    puts

    puts "=====Moving a Piece====="
    puts "After selecting a piece, all of that piece's possibles moves will be displayed and numbered."
    puts "Select the number of the move you want."
    puts "eg."
    puts "Moves for Pawn at [\"c\", 2] are..."
    puts "[1] [\"c\", 3]"
    puts "[2] [\"c\", 4]"
    puts "[3] back"
    puts "If you want to pick a different piece, select the number with \"back\""
    puts

    puts "=====Castling====="
    puts "If the conditions for castling are met and you wish to castle, select your king. The king will have an additional move that is two spaces to the left and/or right of it's current position."
    puts "This is the castle move."
    puts "Selecting this move will move the king and rook to their castle position."

    puts "=====En Passant====="
    puts "If an opponent's pawn moves two squares at once and lands directly beside one of your pawns, you can capture it as if it only moved one square."
    puts "Select a pawn that can perform an en passant and there will be an option that places your pawn behind the opponent's"
    puts "This will move your pawn and capture the opponent's"
    puts
    puts
  end

  # Starts the chess game.
  def start_game
    until @board.in_check?
      piece_location = nil
      piece = nil
      move = nil
      
      loop do
        @board.print_board

        # Checks if player is in checkmate, check, or in stalemate.
        if @board.in_checkmate?
          puts "#{@board.curr_player} is in checkmate."
          puts "#{@board.opponent_player} wins!"
          exit
        elsif @board.in_check?
          puts "You are in check."
          puts "You must move your king."
          piece = @board.curr_team.detect { |p| p.instance_of?(King) }
          piece_location = piece.position
        elsif @board.in_stalemate?
          puts "#{@board.curr_player} is in a stalemate."
          puts "Game ends in a draw."
          exit
        else
          puts "#{@board.curr_player}, select a piece."

          # Player picks a piece.
          piece_location = gets.chomp

          # Piece is validated
          unless @board.validate_user_selection(piece_location)
            puts "Piece is not valid." 
            redo
          end

          piece_location = convert_to_move(piece_location)
          piece = @board.get_piece_at(piece_location)
        end

        piece.select
        @board.print_board

        # Moves for selected piece are printed.
        possible_choices = print_and_return_possible_moves(piece)

        # User picks a move
        move = gets.chomp.to_i
        
        # Move choice gets validated.
        loop do
          break if possible_choices.keys.include?(move)

          puts "Pick a valid move"
          move = gets.chomp.to_i
        end

        # Lets player go back if they want to pick another piece.
        if possible_choices[move] == "back"
          puts "Returning to piece selection..."
          puts
          piece.deselect
          redo
        end

        @board.move_piece_to(piece, move)
        piece.deselect

        # Allows player to promote a pawn if it has reached the opposite end.
        if @board.can_promote?(piece)
          @board.print_board

          puts "Your pawn can be promoted! Enter one of the following choices to turn your pawn into."
          puts "[1] Rook"
          puts "[2] Knight"
          puts "[3] Bishop"
          puts "[4] Queen"
          puts "[5] Pawn"

          promote_choice = nil
          loop do
            promote_choice = gets.chomp.to_i

            break if promote_choice.between?(1, 5)

            puts "Enter a valid choice between 1 - 5."
          end

          @board.promote_pawn_to(piece, promote_choice)
        end
        puts

        @board.switch_player
      end
    end
  end

  # Returns true if the input is 2 characters with the 
  # first charater being a-h and the second character is 1-8.
  # Returns false otherwise.
  # Params
  # user_input: A string.
  def valid_piece?(user_input)
    return false if user_input.length != 2

    file_pos_reg_exp = /^[a-h]$/
    rank_pos_reg_exp = /^[1-8]$/

    return true if user_input[0].match(file_pos_reg_exp) && user_input[1].to_s.match(rank_pos_reg_exp)
  
    return false
  end

  # Returns a 2 character string into an array.
  # Params
  # user_input: A String consisting of 2 characters.
  def convert_to_move(user_input)
    [user_input[0], user_input[1].to_i]
  end

  # Prints possible moves for the given piece and returns the options.
  # Params
  # piece: An object of either pawn, rook, knight, bishop, queen, or king.
  def print_and_return_possible_moves(piece)
    possible_choices = {}
    puts "Possible moves for #{piece.token} at #{piece.position} is..."
    @board.find_moves(piece).each_with_index do |move, index|
      puts "[#{index + 1}] #{move}"

      possible_choices[index + 1] = move
    end

    possible_choices
  end
end
