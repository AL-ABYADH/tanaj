import '../exceptions/invalid_move_exception.dart';
import 'board.dart';
import 'player.dart';
import 'position.dart';
import 'stone.dart';

class Game {
  late final Player human;
  late final Player computer;
  final Board board;
  late final bool playerStarts;

  int moves = 0;

  Game({required this.board, required this.playerStarts}) {
    final boardPositions = board.positions;
    computer = Player(List<Stone>.unmodifiable([
      Stone(boardPositions[0][0]),
      Stone(boardPositions[0][1]),
      Stone(boardPositions[0][2])
    ]));
    human = Player(List<Stone>.unmodifiable([
      Stone(boardPositions[2][0]),
      Stone(boardPositions[2][1]),
      Stone(boardPositions[2][2])
    ]));
  }

  void movePlayerStone(Stone stone, Position position) {
    isEmptyPosition(position)
        ? {whoseTurn.moveStone(stone, position), moves++}
        : throw InvalidMoveException();
  }

  bool isEmptyPosition(Position position) =>
      board.positions
          .expand((pos) => pos)
          .where((pos) => pos.stone == null)
          .contains(position) &&
      !human.stones.map((stone) => stone.position).contains(position) &&
      !computer.stones.map((stone) => stone.position).contains(position);

  Player get whoseTurn =>
      (moves.isEven && playerStarts) || (moves.isOdd && !playerStarts)
          ? human
          : computer;

  bool playerWins(Player player) {
    final stones = player.stones;
    final stonePositions = stones.map((stone) => stone.position);
    final positions = board.positions;

    final row1 = positions[0];
    final row2 = positions[1];
    final row3 = positions[2];

    final col1 = {row1[0], row2[0], row3[0]};
    final col2 = {row1[1], row2[1], row3[1]};
    final col3 = {row1[2], row2[2], row3[2]};

    final diag1 = {row1[0], row2[1], row3[2]};
    final diag2 = {row1[2], row2[1], row3[0]};

    final opponentRow = player == human ? row1 : row3;

    return (opponentRow.toSet().containsAll(stonePositions)) ||
        (row2.toSet().containsAll(stonePositions)) ||
        (col1.containsAll(stonePositions)) ||
        (col2.containsAll(stonePositions)) ||
        (col3.containsAll(stonePositions)) ||
        (diag1.containsAll(stonePositions)) ||
        (diag2.containsAll(stonePositions));
  }

  bool isGameOver() {
    return playerWins(human) || playerWins(computer);
  }
}
