import 'dart:math';

import '../exceptions/invalid_move_exception.dart';
import 'board.dart';
import 'player.dart';
import 'position.dart';
import 'stone.dart';

class Game {
  final Player human;
  final Player computer;
  final Board board;
  final bool humanStarts;
  int moves;

  Game({
    required this.board,
    required this.humanStarts,
    required this.human,
    required this.computer,
    this.moves = 0,
  });

  void movePlayerStone(Stone stone, Position position) {
    if (!isValidMove(stone, position)) {
      throw InvalidMoveException();
    }

    stone.move(position);
    moves++;
  }

  List<MapEntry<Stone, Position>> get allMoves {
    final moves = <MapEntry<Stone, Position>>[];
    for (var stone in whoseTurn.stones) {
      for (var position in stone.position.adjacentPositions) {
        if (isValidMove(stone, position)) {
          moves.add(MapEntry(stone, position));
        }
      }
    }

    return moves;
  }

  bool isValidMove(Stone stone, Position position) {
    final originalStone = [...human.stones, ...computer.stones]
        .firstWhere((element) => element.id == stone.id);

    final originalPosition = board.positions.expand((pos) => pos).firstWhere(
        (element) =>
            element.row == position.row && element.col == position.col);

    return originalStone.position.adjacentPositions
            .contains(originalPosition) &&
        board.positions
            .expand((pos) => pos)
            .where((pos) => pos.stone == null)
            .contains(originalPosition) &&
        !human.stones
            .map((stone) => stone.position)
            .contains(originalPosition) &&
        !computer.stones
            .map((stone) => stone.position)
            .contains(originalPosition);
  }

  Player get whoseTurn =>
      (moves.isEven && humanStarts) || (moves.isOdd && !humanStarts)
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
      humanStarts: humanStarts,
      moves: moves,
    );

    final Map<Stone, Position> bestMove = findBestMove(gameState, 8);

    movePlayerStone(bestMove.keys.first, bestMove.values.first);
  }

  Map<Stone, Position> findBestMove(Game gameState, int depth) {
    int bestScore = -1000;

    // Set the current best move to a random move form the available moves
    // If no better move was found, the move will be random
    final randomMove =
        gameState.allMoves[Random().nextInt(gameState.allMoves.length)];
    Map<Stone, Position> currentBest = {randomMove.key: randomMove.value};

    // Sort moves by heuristic (simple center-first ordering)
    // gameState.allMoves.sort((a, b) {
    //   final aIsCenter = a.value == gameState.board.positions[1][1];
    //   final bIsCenter = b.value == gameState.board.positions[1][1];
    //   if (aIsCenter && !bIsCenter) return -1;
    //   if (!aIsCenter && bIsCenter) return 1;
    //   return 0;
    // });

    for (final move in gameState.allMoves) {
      final stone = move.key;
      final position = move.value;

      final prevPosition = stone.position;
      gameState.movePlayerStone(stone, position);
      final score = minimax(gameState, false, -1000, 1000, depth - 1);
      gameState.movePlayerStone(stone, prevPosition);

      if (score > bestScore) {
        bestScore = score;
        currentBest = {stone: position};
      }
    }
    return currentBest;
  }

  int minimax(Game gameState, bool maximize, int alpha, int beta, int depth) {
    if (gameState.playerWins(gameState.computer)) return 1000;
    if (gameState.playerWins(gameState.human)) return -1000;

    if (depth == 0) {
      return evaluate(gameState);
      // return -1;
    }

    if (maximize) {
      return maximizer(gameState, alpha, beta, depth);
    } else {
      return minimizer(gameState, alpha, beta, depth);
    }
  }

  int maximizer(Game gameState, int alpha, int beta, int depth) {
    int value = -1000;

    for (final move in gameState.allMoves) {
      final stone = move.key;
      final position = move.value;

      final prevPosition = stone.position;
      gameState.movePlayerStone(stone, position);
      value = max(value, minimax(gameState, false, alpha, beta, depth - 1));
      gameState.movePlayerStone(stone, prevPosition);

      alpha = max(alpha, value);
      if (value >= beta) break;
    }

    return value;
  }

  int minimizer(Game gameState, int alpha, int beta, int depth) {
    int value = 1000;

    for (final move in gameState.allMoves) {
      final stone = move.key;
      final position = move.value;

      final prevPosition = stone.position;
      gameState.movePlayerStone(stone, position);
      value = min(value, minimax(gameState, true, alpha, beta, depth - 1));
      gameState.movePlayerStone(stone, prevPosition);

      beta = min(beta, value);
      if (value <= alpha) break;
    }

    return value;
  }

  int evaluate(Game gameState) {
    int lineScore = 0;
    final board = gameState.board;
    final computerStones = gameState.computer.stones;
    final humanStones = gameState.human.stones;

    // Define all winning lines
    final row1 = board.positions[0];
    final row2 = board.positions[1];
    final row3 = board.positions[2];
    final col1 = [row1[0], row2[0], row3[0]];
    final col2 = [row1[1], row2[1], row3[1]];
    final col3 = [row1[2], row2[2], row3[2]];
    final diag1 = [row1[0], row2[1], row3[2]];
    final diag2 = [row1[2], row2[1], row3[0]];

    final List<List<Position>> allLines = [
      row1,
      row2,
      row3,
      col1,
      col2,
      col3,
      diag1,
      diag2
    ];

    // Calculate line potential scores
    for (final line in allLines) {
      int computerStonesCount = 0;
      int humanStonesCount = 0;

      for (final pos in line) {
        final stone = pos.stone;
        if (stone != null) {
          if (computerStones.any((s) => s.id == stone.id)) {
            computerStonesCount++;
          } else if (humanStones.any((s) => s.id == stone.id)) {
            humanStonesCount++;
          }
        }
      }

      if (humanStonesCount == 0 && computerStonesCount > 0) {
        // Only computer has stones in this line
        if (line != row1) {
          lineScore += computerStonesCount * 100;
        }
      } else if (computerStonesCount == 0 && humanStonesCount > 0) {
        // Only human has stones in this line
        if (line != row3) {
          lineScore -= humanStonesCount * 100;
        }
      }
    }

    // Center control bonus
    int centerScore = 0;
    final centerPos = board.positions[1][1];
    if (centerPos.stone != null) {
      if (computerStones.any((s) => s.id == centerPos.stone!.id)) {
        centerScore += 30;
      } else if (humanStones.any((s) => s.id == centerPos.stone!.id)) {
        centerScore -= 30;
      }
    }

    // Mobility calculation
    int computerMobility = computerStones
        .expand((stone) => stone.position.adjacentPositions)
        .where((pos) => pos.stone == null)
        .length;

    int humanMobility = humanStones
        .expand((stone) => stone.position.adjacentPositions)
        .where((pos) => pos.stone == null)
        .length;

    int mobilityScore = computerMobility - humanMobility;

    final total = lineScore + centerScore + mobilityScore;

    return total;
  }
}
