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
  int moves;

  Game({
    required this.board,
    required this.playerStarts,
    required this.human,
    required this.computer,
    this.moves = 0,
  });

  void movePlayerStone(Stone stone, Position position) {
    final originalStone = [...human.stones, ...computer.stones]
        .firstWhere((element) => element.id == stone.id);

    final originalPosition = board.positions.expand((pos) => pos).firstWhere(
        (element) =>
            element.row == position.row && element.col == position.col);
    if (!isValidMove(originalStone, originalPosition)) {
      throw InvalidMoveException();
    }

    originalStone.move(originalPosition);
    moves++;
  }

  bool isValidMove(Stone stone, Position position) {
    return stone.position.adjacentPositions.contains(position) &&
        board.positions
            .expand((pos) => pos)
            .where((pos) => pos.stone == null)
            .contains(position) &&
        !human.stones.map((stone) => stone.position).contains(position) &&
        !computer.stones.map((stone) => stone.position).contains(position);
  }

  Player get whoseTurn =>
      (moves.isEven && playerStarts) || (moves.isOdd && !playerStarts)
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

    final gameState = Game(
      board: board,
      human: human,
      computer: computer,
      playerStarts: playerStarts,
      moves: moves,
    );

    final Map<Stone, Position>? bestMove = findBestMove(gameState, 10);

    if (bestMove == null) throw MoveNotFoundException();

    movePlayerStone(bestMove.keys.first, bestMove.values.first);
  }

  Map<Stone, Position>? findBestMove(Game gameState, int depth) {
    int bestScore = -2;
    for (var stone in gameState.whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        if (!gameState.isValidMove(stone, position)) continue;

        final prevPosition = stone.position;
        gameState.movePlayerStone(stone, position);
        final score = gameState.minimax(gameState, false, -2, 2, depth - 1);
        gameState.movePlayerStone(stone, prevPosition);
        if (score > bestScore) {
          bestScore = score;
          return {stone: position};
        }
      }
    }
    return null;
  }

  int minimax(
      Game gameState, bool maximize, double alpha, double beta, int depth) {
    if (playerWins(computer)) return 1;
    if (playerWins(human)) return -1;
    if (depth == 0) {
      return evaluate(gameState);
    }

    if (maximize) {
      return gameState.maximizer(gameState, alpha, beta, depth);
    } else {
      return gameState.minimizer(gameState, alpha, beta, depth);
    }
  }

  int maximizer(Game gameState, double alpha, double beta, int depth) {
    int bestScore = -2;
    for (var stone in gameState.whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        if (!gameState.isValidMove(stone, position)) continue;

        final prevPosition = stone.position;
        gameState.movePlayerStone(stone, position);
        final score =
            gameState.minimax(gameState, false, alpha, beta, depth - 1);
        gameState.movePlayerStone(stone, prevPosition);
        bestScore = max(bestScore, score);
        alpha = max(alpha, bestScore.toDouble());
        if (beta <= alpha) break;
      }
    }
    return bestScore;
  }

  int minimizer(Game gameState, double alpha, double beta, int depth) {
    int bestScore = 2;
    for (var stone in gameState.whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        if (!gameState.isValidMove(stone, position)) continue;

        final prevPosition = stone.position;
        gameState.movePlayerStone(stone, position);
        final score =
            gameState.minimax(gameState, true, alpha, beta, depth - 1);
        gameState.movePlayerStone(stone, prevPosition);
        bestScore = min(bestScore, score);
        beta = min(beta, bestScore.toDouble());
        if (beta <= alpha) break;
      }
    }
    return bestScore;
  }

  int evaluate(Game gameState) {
    // Implement evaluation logic here to estimate the game state.
    // Return a positive score for favorable positions for the computer,
    // negative for favorable positions for the human, and 0 for neutral positions.
    return -1;
  }
}
