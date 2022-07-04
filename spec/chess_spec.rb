require "game.rb"
require "board.rb"
Dir["./lib/pieces/*.rb"].sort.each { |file| require file }

full_board = Board.new

check_test_board = Board.new
check_test_board.switch_player
check_test_board.capture_piece_at(["c", 2])
check_test_board.capture_piece_at(["d", 2])
check_test_board.capture_piece_at(["e", 2])
check_test_board.capture_piece_at(["f", 2])
check_test_board.switch_player
check_test_board.capture_piece_at(["d", 7])
check_test_board.capture_piece_at(["e", 7])
check_test_board.capture_piece_at(["f", 7])

check_test_board.print_board

empty_moves = ["back"]

describe Board do
  describe "#find_moves" do
    starting_pawns = full_board.curr_team.select { |piece| piece.instance_of?(Pawn)}

    it "returns moves for a piece" do
      piece1_bishop = full_board.curr_team[12]

      piece2_bishop = full_board.curr_team[14]

      expect(full_board.find_moves(piece1_bishop)).to eql(empty_moves)

      expect(full_board.find_moves(piece2_bishop)).to eql(empty_moves)

    end
  end

  describe "#in_check?" do
    it "returns true if curr team is in check" do
      # King should not be in check.
      expect(check_test_board.in_check?).to eql(false)
    end

    it "returns true if curr team is in check" do
      # Bishop is moved to put king in check.
      check_test_board.switch_player

      bishop = check_test_board.get_piece_at(["f", 8])
      puts "bishop moves: #{check_test_board.find_moves(bishop)}"
      check_test_board.move_piece_to(bishop, 4)  

      check_test_board.switch_player
      expect(check_test_board.in_check?).to eql(true)
    end

    it "returns true if curr team is in check" do
      # King should move out of check.
      king = check_test_board.get_piece_at(["e", 1])
      puts "king moves: #{check_test_board.find_moves(king)}"

      check_test_board.move_piece_to(king, 1)

      check_test_board.print_board
      expect(check_test_board.in_check?).to eql(false)
    end

    it "returns true if curr team is in check" do
      # Queen is moved to put king in check.
      check_test_board.switch_player

      queen = check_test_board.get_piece_at(["d", 8])
      puts "queen moves: #{check_test_board.find_moves(queen)}"

      check_test_board.move_piece_to(queen, 8)

      check_test_board.print_board
      check_test_board.switch_player
      expect(check_test_board.in_check?).to eql(true)
    end
  end
end
