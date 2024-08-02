import 'dart:io';

enum PieceType { king, queen, rook, bishop, knight, pawn, empty }
enum Player { white, black, none }

class Piece {
  PieceType type;
  Player player;

  Piece(this.type, this.player);
}

class ChessBoard {
  List<List<Piece>> board = List.generate(
    8,
    (i) => List.generate(8, (j) => Piece(PieceType.empty, Player.none)),
  );

  ChessBoard() {
    _initializeBoard();
  }

  void _initializeBoard() {
    // Initialize white pieces
    board[0][0] = board[0][7] = Piece(PieceType.rook, Player.white);
    board[0][1] = board[0][6] = Piece(PieceType.knight, Player.white);
    board[0][2] = board[0][5] = Piece(PieceType.bishop, Player.white);
    board[0][3] = Piece(PieceType.queen, Player.white);
    board[0][4] = Piece(PieceType.king, Player.white);
    for (int i = 0; i < 8; i++) {
      board[1][i] = Piece(PieceType.pawn, Player.white);
    }

    // Initialize black pieces
    board[7][0] = board[7][7] = Piece(PieceType.rook, Player.black);
    board[7][1] = board[7][6] = Piece(PieceType.knight, Player.black);
    board[7][2] = board[7][5] = Piece(PieceType.bishop, Player.black);
    board[7][3] = Piece(PieceType.queen, Player.black);
    board[7][4] = Piece(PieceType.king, Player.black);
    for (int i = 0; i < 8; i++) {
      board[6][i] = Piece(PieceType.pawn, Player.black);
    }
  }

  void displayBoard() {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        stdout.write(_pieceSymbol(board[i][j]) + ' ');
      }
      stdout.writeln();
    }
  }

  String _pieceSymbol(Piece piece) {
    switch (piece.type) {
      case PieceType.king:
        return piece.player == Player.white ? 'K' : 'k';
      case PieceType.queen:
        return piece.player == Player.white ? 'Q' : 'q';
      case PieceType.rook:
        return piece.player == Player.white ? 'R' : 'r';
      case PieceType.bishop:
        return piece.player == Player.white ? 'B' : 'b';
      case PieceType.knight:
        return piece.player == Player.white ? 'N' : 'n';
      case PieceType.pawn:
        return piece.player == Player.white ? 'P' : 'p';
      case PieceType.empty:
      default:
        return '.';
    }
  }

  bool movePiece(int startX, int startY, int endX, int endY) {
    if (startX < 0 || startX >= 8 || startY < 0 || startY >= 8 || endX < 0 || endX >= 8 || endY < 0 || endY >= 8) {
      return false;
    }

    Piece startPiece = board[startX][startY];
    Piece endPiece = board[endX][endY];

    if (startPiece.player == Player.none || (endPiece.player != Player.none && startPiece.player == endPiece.player)) {
      return false;
    }

    // Simple move logic: allow any move to an empty square or capture an opponent's piece
    board[endX][endY] = startPiece;
    board[startX][startY] = Piece(PieceType.empty, Player.none);
    return true;
  }
}

void main() {
  ChessBoard chessBoard = ChessBoard();
  chessBoard.displayBoard();

  while (true) {
    print('Enter your move (e.g., 0 1 2 1 to move a piece from 0,1 to 2,1):');
    String input = stdin.readLineSync()!;
    List<String> parts = input.split(' ');
    if (parts.length != 4) {
      print('Invalid input. Please enter 4 integers separated by spaces.');
      continue;
    }

    int startX = int.parse(parts[0]);
    int startY = int.parse(parts[1]);
    int endX = int.parse(parts[2]);
    int endY = int.parse(parts[3]);

    if (chessBoard.movePiece(startX, startY, endX, endY)) {
      chessBoard.displayBoard();
    } else {
      print('Invalid move. Try again.');
    }
  }
}
