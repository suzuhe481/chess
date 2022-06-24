# Game Object.
# Containing the board and relaying instructions to the player.
class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def start
    puts "Welcome to Chess. Player 1 will move first."

    until @board.in_check?
      piece_location = nil
      piece = nil
      move = nil
      

      loop do
        @board.print_board
        puts "#{@board.curr_player}, select a piece."

        piece_location = gets.chomp


        unless @board.validate_user_selection(piece_location)
          puts "Piece is not valid." 
          redo
        end

        piece_location = convert_to_move(piece_location)
        piece = @board.get_piece_at(piece_location)

        piece.select
        @board.print_board

        puts "Possible moves for #{piece.token} is..."
        puts @board.find_moves(piece)

        move = gets.chomp

        if move == "back"
          piece.deselect
          redo
        end

        

      end



      # piece = nil
      # piece_location = nil
      # loop do
      #   puts "#{@board.curr_player}, pick a piece."
      #   piece_location = gets.chomp

      #   break if @board.validate_user_selection(piece_location)

      #   puts "Piece is not valid."
      #   puts "#{@board.curr_player}, pick a piece."
      # end

      # piece_location = convert_to_move(piece_location)
      # piece = @board.get_piece_at(piece_location)

      # puts "Your selected piece is: #{piece.token} at #{piece.position}"
      # puts "Available moves for #{piece.token} is..."
      # @board.find_moves(piece).each { |move| print "#{move}, "}
      # puts
      
      # @board.switch_player
    end

    # TESTING SWITCH_PLAYER METHOD
    # puts "curr player: #{@board.curr_player}"
    # print "curr team:" 
    # @board.curr_team.each { |piece| p piece.token }
    # puts

    # @board.switch_player

    # puts "curr player: #{@board.curr_player}"
    # print "curr team:" 
    # @board.curr_team.each { |piece| p piece.token }
    # puts

    # @board.switch_player

    # puts "curr player: #{@board.curr_player}"
    # print "curr team:" 
    # @board.curr_team.each { |piece| p piece.token }


    # TESTING GET_PIECE METHOD
    # piece = @board.get_piece_at(["a", 7])
    # p piece


    # puts "#{@board.curr_team[10].token} at #{@board.curr_team[10].position}"
    # p @board.find_moves(@board.curr_team[10]).sort

    # print @board.find_moves(@board.curr_team[9])
    # puts
    # puts @board.curr_team[14].token
    # print @board.find_moves(@board.curr_team[14])

    # @board.curr_team.each do |piece|
    #   puts piece
    #   puts "#{piece.token} at #{piece.position}"
    #   puts "Available moves: #{@board.find_moves(piece)}"
    #   puts
    # end

    # @board.print_board
    # @board.capture_piece_at(["b", 8])
    # @board.capture_piece_at(["c", 7])
    # @board.capture_piece_at(["g", 8])
    # @board.capture_piece_at(["a", 7])
    # @board.capture_piece_at(["h", 7])

    # @board.switch_player
    

    # @board.capture_piece_at(["b", 1])
    # @board.capture_piece_at(["c", 1])
    # @board.capture_piece_at(["g", 2])
    # @board.capture_piece_at(["a", 2])
    # @board.capture_piece_at(["h", 1])

    # @board.print_board
    # puts "#{@board.curr_player} captures"
    # @board.curr_team_captures.each { |x| p x.token }

    # puts "#{@board.opponent_player} captures"
    # @board.opponent_team_captures.each { |x| p x.token }

    # puts @board.opponent_in_check?

    # p @board.in_checkmate?


    # @board.switch_player

    # piece_to_move1 = @board.get_piece_at(["a", 1])
    # piece_to_move1.move_to("c", 3)

    # piece2 = @board.get_piece_at(["a", 7])
    # piece2.move_to("e", 3)
    # @board.print_board


    # piece = @board.get_piece_at(["d", 2])
    
    # puts "#{piece.token} at #{piece.position} movements"
    # p @board.find_moves(piece)



    # @board.switch_player
    
    # piece_to_move1 = @board.get_piece_at(["a", 1])
    # piece_to_move1.move_to("e", 6)

    # piece2 = @board.get_piece_at(["a", 7])
    # piece2.move_to("c", 6)
    # @board.print_board


    # Output pawn variables
    # puts "current team"
    # @board.curr_team.each do |piece|
    #   if piece.instance_of?(Pawn)
    #     puts "Pawn #{piece.token}"
    #     puts " first move: #{piece.first_move}"
    #     puts " en passant: #{piece.en_passant_capturable}"
    #   end
    # end
    # puts
    # puts "opponent team"
    # @board.opponent_team.each do |piece|
    #   if piece.instance_of?(Pawn)
    #     puts "Pawn #{piece.token}"
    #     puts " first move: #{piece.first_move}"
    #     puts " en passant: #{piece.en_passant_capturable}"
    #   end
    # end

    # My movement
    # pawn = @board.get_piece_at(["d", 2])
    # pawn.move_to("d", 5)
    # @board.print_board
    # @board.switch_player

    # Output pawn variables
    # puts "current team"
    # @board.curr_team.each do |piece|
    #   if piece.instance_of?(Pawn)
    #     puts "Pawn #{piece.token}"
    #     puts " first move: #{piece.first_move}"
    #     puts " en passant: #{piece.en_passant_capturable}"
    #   end
    # end
    # puts

    # puts "opponent team"
    # @board.opponent_team.each do |piece|
    #   if piece.instance_of?(Pawn)
    #     puts "Pawn #{piece.token}"
    #     puts " first move: #{piece.first_move}"
    #     puts " en passant: #{piece.en_passant_capturable}"
    #   end
    # end

    
    # opponent_pawn = @board.get_piece_at(["c", 8])
    # opponent_pawn.move_to("c", 5)

    # opponent_pawn = @board.get_piece_at(["e", 7])
    # opponent_pawn.move_to("e", 5)
    # @board.print_board
    # @board.switch_player

    # Output pawn variables
    # puts "current team"
    # @board.curr_team.each do |piece|
    #   if piece.instance_of?(Pawn)
    #     puts "Pawn #{piece.token}"
    #     puts " first move: #{piece.first_move}"
    #     puts " en passant: #{piece.en_passant_capturable}"
    #   end
    # end
    # puts

    # puts "opponent team"
    # @board.opponent_team.each do |piece|
    #   if piece.instance_of?(Pawn)
    #     puts "Pawn #{piece.token}"
    #     puts " first move: #{piece.first_move}"
    #     puts " en passant: #{piece.en_passant_capturable}"
    #   end
    # end

    # pawn = @board.get_piece_at(["d", 5])
    # p @board.find_moves(pawn)
    
    

    # p "Pawn first move: #{pawn.first_move}"
    # p "Pawn en passant: #{pawn.en_passant_capturable}"


    
    # @board.print_board

    # p pawn.movement
    # p @board.find_moves(pawn)

    # @board.reset_opponent_en_passant


    # pawn = @board.get_piece_at(["d", 2])
    # @board.capture_piece_at(["d", 4])
    # @board.capture_piece_at(["e", 4])
    # pawn.move_to("d", 8)

    # @board.print_board

    # puts @board.promote_pawn_to(pawn, "Bi")

    # @board.print_board

    # p @board.curr_team_captures
    # p @board.opponent_team_captures


    # START**************************** en passant for black team

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["d", 7])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 2)

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["c", 2])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 2)

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["d", 5])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 2)

    # @board.print_board
    # @board.switch_player

    # Double movement for 1 team
    # piece = @board.get_piece_at(["d", 2])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 1)

    # @board.print_board

    # piece = @board.get_piece_at(["d", 3])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 1)

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["c", 4])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 1)

    # @board.print_board
    # @board.switch_player

    # START************************ en passant for white team

    # piece = @board.get_piece_at(["d", 2])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 2)

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["c", 7])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 2)

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["d", 4])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 2)

    # @board.print_board
    # @board.switch_player

    # # Double moving pawn 1 space
    # piece = @board.get_piece_at(["d", 7])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 1)

    # @board.print_board

    # piece = @board.get_piece_at(["d", 6])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 1)

    # @board.print_board
    # @board.switch_player

    # piece = @board.get_piece_at(["c", 5])
    # p @board.find_moves(piece)
    # @board.move_piece_to(piece, @board.find_moves(piece), 1)

    # @board.print_board
    # @board.switch_player

    

    # Castling tests
    # @board.switch_player

    # @board.print_board

    # king = @board.get_piece_at(["e", 8])
    # king_moves = @board.find_moves(king)
    # puts "king moves: #{king_moves}"
    # @board.move_piece_to(king, king_moves, 3)

    # @board.print_board

    
  end

  # Returns true if the input is 2 characters with the 
  # first charater being a-h and the second character is 1-8.
  # Returns false otherwise.
  def valid_piece?(user_input)
    return false if user_input.length != 2

    file_pos_reg_exp = /^[a-h]$/
    rank_pos_reg_exp = /^[1-8]$/

    return true if user_input[0].match(file_pos_reg_exp) && user_input[1].to_s.match(rank_pos_reg_exp)
  
    return false
  end

  # Returns a 2 character string into an array.
  def convert_to_move(user_input)
    [user_input[0], user_input[1].to_i]
  end
end
