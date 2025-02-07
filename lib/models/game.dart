import 'board.dart';
import 'player.dart';
import 'stone.dart';

class Game {
  late final Player player;
  late final Player computer;
  final Board board;

  Game(this.board) {
    final boardPositions = board.positions;
    computer = Player([
      Stone(boardPositions[0][0]),
      Stone(boardPositions[0][1]),
      Stone(boardPositions[0][2])
    ]);
    player = Player([
      Stone(boardPositions[2][0]),
      Stone(boardPositions[2][1]),
      Stone(boardPositions[2][2])
    ]);
  }
}
