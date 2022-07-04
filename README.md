# Chess
This is a chess game that is ran through the command line. Two human players take turns moving their respective pieces.

## Chess Instructions
- Pawn
  - Movement: On a pawn's first turn, can move 2 spaces forward. Otherwise, moves 1 space forward at a time.
  - Capturing: 1 space away diagonally to the left or right, or by using en-passant.
- Rook
  - Movement: Moves horizontally or vertically for any number of spaces.
  - Capturing: Can capture a piece it lands on.
- Knight
  - Movement: Moves 2 spaces vertically and 1 space horitonzally, or 2 spaces horizontally and 1 space vertically.
  - Capturing: Can capture a piece it lands on.
- Bishop
  - Movement: Moves diagonally for any number of spaces.
  - Capturing: Can capture a piece it lands on.
- Queen
  - Movement: Move horizontally, vertically, or diagonally for any number of spaces.
  - Capturing: Can capture a piece it lands on.
- King
  - Movement: Moves horizontally, vertically, or diagonally for 1 space.
  - Capturing: Can capture a piece it lands on.

## Win Conditions
- Check
  - When you put your piece in a position where it can capture your opponent's king, your opponent is in check and must move a piece in a way that gets them out of check.
- Checkmate
  - When your opponent is in check and there is no move that can get them out of check. You win the game.
- Stalemate
  - When your opponent is not in check, but cannot make a move without putting themselves in check. The game is a draw.
  
For more detailed instructions, visit [chessvariants.org/d.chess/chess.html](chessvariants.org/d.chess/chess.html)

### Bugs
- When put in check, you must move your king. Player should be able to move any piece as long as it gets them out of check.