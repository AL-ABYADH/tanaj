import 'package:flutter/material.dart';

import '../models/stone.dart';

class StoneWidget extends StatelessWidget {
  final Stone stone;
  final Color color;
  final bool canDrag;

  const StoneWidget({
    super.key,
    required this.stone,
    required this.color,
    required this.canDrag,
  });

  @override
  Widget build(BuildContext context) {
    final widget = CircleAvatar(
      radius: 50,
      backgroundColor: color,
    );
    return canDrag
        ? Draggable<Stone>(
            data: stone,
            feedback: CircleAvatar(
              radius: 100,
              backgroundColor: color,
            ),
            childWhenDragging: const SizedBox(),
            child: widget,
          )
        : widget;
  }
}
