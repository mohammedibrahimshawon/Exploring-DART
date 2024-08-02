import 'dart:io';

class TicTacToe {
  List<List<String>> board = List.generate(3, (i) => List.generate(3, (j) => ' '));
  String currentPlayer = 'X';

  void displayBoard() {
    for (var row in board) {
      print(row.join('|'));
    }
  }

  bool makeMove(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col] != ' ') {
      return false;
    }
    board[row][col] = currentPlayer;
    return true;
  }

  bool checkWin() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer) {
        return true;
      }
      if (board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer) {
        return true;
      }
    }
    if (board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) {
      return true;
    }
    if (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer) {
      return true;
    }
    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell == ' ') {
          return false;
        }
      }
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }

  void play() {
    while (true) {
      displayBoard();
      print('Player $currentPlayer, enter your move (row and column):');
      String input = stdin.readLineSync()!;
      List<String> parts = input.split(' ');
      if (parts.length != 2) {
        print('Invalid input. Please enter two integers separated by a space.');
        continue;
      }

      int row = int.parse(parts[0]);
      int col = int.parse(parts[1]);

      if (makeMove(row, col)) {
        if (checkWin()) {
          displayBoard();
          print('Player $currentPlayer wins!');
          break;
        } else if (isBoardFull()) {
          displayBoard();
          print('The game is a draw!');
          break;
        }
        switchPlayer();
      } else {
        print('Invalid move. Try again.');
      }
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.play();
}
