#CHESS - given a board state that the user enters, with 1 white figure and up to 16 black figures, 
#which black figures can the white figure take?

# Creates an empty chess board with coordinates a1 to h8
def create_board():
    board = {}
    letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    for i in range(8):
        for j in range(8):
            coordinate = f'{letters[i]}{j + 1}' 
            board[coordinate] = None
    return board

# Gets a valid chess piece input from the user
def get_piece_input(prompt, valid_pieces):
    while True:
        piece = input(prompt).strip().lower()
        if piece in valid_pieces:
            return piece
        print("Piece name is incorrect, check again.")

# Gets a valid coordinate input from the user
def get_coordinate_input(prompt, board):
    while True:
        coordinate = input(prompt).strip().lower()
        if coordinate in board and board[coordinate] is None:
            return coordinate
        print("Piece coordinate is incorrect, check again.")

# Determines which black pieces a white pawn can capture
def pawn_captures(position, board):
    captures = []
    # Diagonal directions a pawn can capture
    capture_directions = [(-1, 1), (1, 1)]  
    # Convert column letter to index and row number to zero-based index
    current_col = position[0]
    current_row = int(position[1])
    row_letters = 'abcdefgh'  

    for direction in capture_directions:
        delta_col, delta_row = direction
        # Calculate new position
        new_col_index = row_letters.index(current_col) + delta_col
        new_row = current_row + delta_row

        # Check if the new position is on the board
        if 0 <= new_col_index < 8 and 1 <= new_row <= 8:
            new_col = row_letters[new_col_index]
            new_position = f'{new_col}{new_row}'
            # Check if the new position is occupied by a black piece
            if new_position in board and board[new_position] and board[new_position][0] == 'black':
                captures.append((new_position, board[new_position][1]))

    return captures

# Determines which black pieces a white rook can capture
def rook_captures(position, board):
    captures = []
    # Directions a rook can move
    move_directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
    # Convert column letter to index and row number to zero-based index
    current_col = position[0]
    current_row = int(position[1])
    row_letters = 'abcdefgh' 

    for direction in move_directions:
        delta_col, delta_row = direction
        # Initialize new position
        new_col_index = row_letters.index(current_col)
        new_row = current_row

        while True:
            # Update position in the current direction
            new_col_index += delta_col
            new_row += delta_row
            
            # Check if the new position is off the board
            if not (0 <= new_col_index < 8 and 1 <= new_row <= 8):
                break
            
            new_position = f'{row_letters[new_col_index]}{new_row}'

            if new_position in board:
                # Check if the new position is occupied by a black piece
                if board[new_position] and board[new_position][0] == 'black':
                    captures.append((new_position, board[new_position][1]))
                    break
                # If occupied by any piece, stop in that direction
                elif board[new_position] is None:
                    continue
                else:
                    break

    return captures

# Main function to run the chess capture program
def main():
    board = create_board()

    # Input for white piece
    white_piece = get_piece_input("Choose your white piece (rook or pawn): ", ["rook", "pawn"])
    white_position = get_coordinate_input("Enter the coordinates from A1 to H8 for your white piece: ", board)
    board[white_position] = ("white", white_piece)

    black_pieces_list = ["rook", "knight", "bishop", "king", "queen", "bishop", "knight", "rook", "pawn"] + ["pawn"] * 7
    black_pieces = []

    placed_first_piece = False

    # Input for black pieces
    while True:
        # Ensure at least one black piece is placed
        if not placed_first_piece:
            print("You must place at least one black piece.")

        # Display remaining black pieces    
        print(f"Remaining black pieces: {black_pieces_list}")

        # Allow user to type 'done' if they have placed at least one black piece
        if black_pieces and input("Type 'done' if you are finished, or press Enter to continue: ").strip().lower() == 'done':
            break
        
        # Get black piece type and position from the user
        piece = get_piece_input("Choose a black piece from the remaining list: ", black_pieces_list)
        black_pieces_list.remove(piece)
        position = get_coordinate_input(f"Enter the position from A1 to H8 for black {piece}: ", board)
        board[position] = ("black", piece)
        black_pieces.append((piece, position))
        placed_first_piece = True

    # Determine which black pieces can be captured by the white piece
    captures = []
    if white_piece == 'pawn':
        captures = pawn_captures(white_position, board)
    elif white_piece == 'rook':
        captures = rook_captures(white_position, board)

    if captures:
        print("White piece can capture the following black pieces:")
        for pos, piece in captures:
            print(f'{piece} at {pos}')
    else:
        print("No black pieces can be captured by the white piece.")

if __name__ == "__main__":
    main()

