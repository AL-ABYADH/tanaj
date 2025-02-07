import 'dart:math';

import '../exceptions/invalid_move_exception.dart';
import '../exceptions/move_not_found_exception.dart';
import 'board.dart';
import 'player.dart';
import 'position.dart';
import 'stone.dart';

class Game {
  final Player human;
  final Player computer;
  final Board board;
  final bool playerStarts;

  int _moves = 0;

  Game({
    required this.board,
    required this.playerStarts,
  })  : human = Player(List<Stone>.unmodifiable([
          Stone(board.positions[2][0]),
          Stone(board.positions[2][1]),
          Stone(board.positions[2][2]),
        ])),
        computer = Player(List<Stone>.unmodifiable([
          Stone(board.positions[0][0]),
          Stone(board.positions[0][1]),
          Stone(board.positions[0][2]),
        ]));

  Game copyWith({bool? playerStarts, int? maxSearchDepth}) => Game(
        board: board,
        playerStarts: playerStarts ?? this.playerStarts,
      ).._moves = _moves;

  void movePlayerStone(Stone stone, Position position) {
    stone.position.adjacentPositions.contains(position) &&
            isEmptyPosition(position)
        ? {whoseTurn.moveStone(stone, position), _moves++}
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
      (_moves.isEven && playerStarts) || (_moves.isOdd && !playerStarts)
          ? human
          : computer;

  bool playerWins(Player player) {
    final stonePositions = player.stones.map((stone) => stone.position);
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

  void computerPlay() {
    if (isGameOver()) return;

    final gameState = copyWith();

    final Map<Stone, Position>? bestMove = findBestMove(gameState);

    if (bestMove == null) throw MoveNotFoundException();

    movePlayerStone(bestMove.keys.first, bestMove.values.first);
  }

  Map<Stone, Position>? findBestMove(Game gameState) {
    int bestScore = -1;
    for (var stone in whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        if (isEmptyPosition(position)) {
          final prevPosition = stone.position.copyWith();
          gameState.movePlayerStone(stone, position);
          final score = minimax(gameState, false);
          gameState.movePlayerStone(stone, prevPosition);
          if (score > bestScore) {
            bestScore = score;
            return {stone: position};
          }
        }
      }
    }
    return null;
  }

  int minimax(Game gameState, bool maximize) {
    if (playerWins(computer)) return 1;
    if (playerWins(human)) return -1;

    if (maximize) {
      return maximizer(gameState);
    } else {
      return minimizer(gameState);
    }
  }

  int maximizer(Game gameState) {
    int bestScore = -1;
    for (var stone in whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        final prevPosition = stone.position.copyWith();
        gameState.movePlayerStone(stone, position);
        final score = minimax(gameState, false);
        gameState.movePlayerStone(stone, prevPosition);
        bestScore = max(bestScore, score);
      }
    }
    return bestScore;
  }

  int minimizer(Game gameState) {
    int bestScore = 1;
    for (var stone in whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        final prevPosition = stone.position.copyWith();
        gameState.movePlayerStone(stone, position);
        final score = minimax(gameState, true);
        gameState.movePlayerStone(stone, prevPosition);
        bestScore = min(bestScore, score);
      }
    }
    return bestScore;
  }
}
