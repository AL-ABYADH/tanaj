import 'package:flutter/material.dart';

import '../models/game.dart';
import '../models/position.dart';
import '../models/stone.dart';
import 'position_widget.dart';
import 'stone_widget.dart';

class BoardWidget extends StatelessWidget {
  final Game game;
  final void Function(Stone, Position) moveStone;

  const BoardWidget({
    super.key,
    required this.game,
    required this.moveStone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[0][0],
              stone: game.board.positions[0][0].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[0][0].stone),
                      stone: game.board.positions[0][0].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[0][0].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[0][0].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[0][1],
              stone: game.board.positions[0][1].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[0][1].stone),
                      stone: game.board.positions[0][1].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[0][1].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[0][1].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[0][2],
              stone: game.board.positions[0][2].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[0][2].stone),
                      stone: game.board.positions[0][2].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[0][2].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[0][2].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[1][0],
              stone: game.board.positions[1][0].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[1][0].stone),
                      stone: game.board.positions[1][0].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[1][0].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[1][0].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[1][1],
              stone: game.board.positions[1][1].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[1][1].stone),
                      stone: game.board.positions[1][1].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[1][1].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[1][1].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[1][2],
              stone: game.board.positions[1][2].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[1][2].stone),
                      stone: game.board.positions[1][2].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[1][2].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[1][2].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[2][0],
              stone: game.board.positions[2][0].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[2][0].stone),
                      stone: game.board.positions[2][0].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[2][0].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[2][0].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[2][1],
              stone: game.board.positions[2][1].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[2][1].stone),
                      stone: game.board.positions[2][1].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[2][1].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[2][1].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
            PositionWidget(
              isValidMove: game.isValidMove,
              moveStone: moveStone,
              position: game.board.positions[2][2],
              stone: game.board.positions[2][2].stone != null
                  ? StoneWidget(
                      canDrag: game.whoseTurn == game.human &&
                          game.human.stones
                              .contains(game.board.positions[2][2].stone),
                      stone: game.board.positions[2][2].stone!,
                      color: game.isGameOver() &&
                              game.human.stones
                                  .contains(game.board.positions[2][2].stone)
                          ? Colors.green
                          : game.human.stones
                                  .contains(game.board.positions[2][2].stone)
                              ? Colors.blue
                              : Colors.red,
                    )
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
