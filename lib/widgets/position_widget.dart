import 'package:flutter/material.dart';

import '../models/position.dart';
import '../models/stone.dart';
import 'stone_widget.dart';

class PositionWidget extends StatelessWidget {
  final bool Function(Stone, Position) isValidMove;
  final void Function(Stone, Position) moveStone;
  final Position position;
  final StoneWidget? stone;

  const PositionWidget({
    super.key,
    required this.isValidMove,
    required this.moveStone,
    required this.position,
    this.stone,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Stone>(
      onAcceptWithDetails: (details) => moveStone(details.data, position),
      onWillAcceptWithDetails: (details) => isValidMove(details.data, position),
      builder: (context, candidateItems, rejectedItems) => SizedBox(
        height: 200,
        width: 200,
        child: stone,
      ),
    );
  }
}
