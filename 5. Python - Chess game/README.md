# Chess.py

## Overview
This Python program answers a simple question: Given a board state that the user enters, with 1 white piece and up to 16 black pieces, which black pieces can the white piece capture?

## Functionality

### User Input:
1. The user is first asked to input a **white chess piece** and its position on the board. The user can choose between two pieces: **pawn** or **rook**. The input format is:  
   `piece coordinate` (e.g., `pawn e4`).
   
2. After the white piece is successfully added, the user is prompted to enter **black pieces**, one by one, in the same format. The user must add at least **1 black piece** but no more than **16**. Once at least one black piece is added, the user can type `done` to stop adding more pieces.

3. The coordinates are entered in the standard format: **letters a-h** and **digits 1-8** (e.g., `a1`, `d4`, `h8`).

### Validation:
- After each piece is added, the program provides a confirmation message if the piece was added successfully, or an error message explaining any issues.
  
### Capture Logic:
- Once all pieces are added, the program checks which **black pieces** can be captured by the white piece based on the rules of chess:
  - **Pawn**: Can capture diagonally forward to the left or right.
  - **Rook**: Can capture in any straight line (horizontal or vertical), as long as there are no other pieces blocking the path.

### Output:
- The program prints out the **black pieces**, if any, that the white piece can capture.

## Example Usage:

1. Input white piece:  
   `pawn e4`
   
2. Input black pieces:  
   `black pawn d5`  
   `black rook e6`  
   `black bishop f3`  
   `done`

3. Output:  
   "The white pawn at e4 can capture black pawn at d5."

## Notes:
- The program supports a maximum of 16 black pieces and ensures valid coordinate inputs.
- The white piece's movement rules are based on standard chess rules for pawns and rooks.
