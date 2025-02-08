import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/game.dart';
import '../models/player.dart';
import '../models/position.dart';
import '../models/stone.dart';
import '../widgets/board_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final Game game;

  @override
  void initState() {
    super.initState();
    final board = Board();
    game = Game(
        board: board,
        human: Player(
            'human',
            List<Stone>.unmodifiable([
              Stone(1, board.positions[2][0]),
              Stone(2, board.positions[2][1]),
              Stone(3, board.positions[2][2]),
            ])),
        computer: Player(
            'computer',
            List<Stone>.unmodifiable([
              Stone(4, board.positions[0][0]),
              Stone(5, board.positions[0][1]),
              Stone(6, board.positions[0][2]),
            ])),
        playerStarts: true);
    game.board.positions[0][0].stone = game.computer.stones[0];
    game.board.positions[0][1].stone = game.computer.stones[1];
    game.board.positions[0][2].stone = game.computer.stones[2];
    game.board.positions[2][0].stone = game.human.stones[0];
    game.board.positions[2][1].stone = game.human.stones[1];
    game.board.positions[2][2].stone = game.human.stones[2];
  }

  void _moveStone(Stone stone, Position position) => setState(() {
        game.movePlayerStone(stone, position);
        game.computerPlay();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                  height: 50,
                  child: game.playerWins(game.human)
                      ? const Text("You win!",
                          style: TextStyle(
                            fontSize: 40,
                          ))
                      : game.playerWins(game.computer)
                          ? const Text("You lose!",
                              style: TextStyle(
                                fontSize: 40,
                              ))
                          : null),
              const SizedBox(
                height: 20,
              ),
              BoardWidget(
                game: game,
                moveStone: _moveStone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
