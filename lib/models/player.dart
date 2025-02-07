import 'position.dart';
import 'stone.dart';

class Player {
  final List<Stone> stones;

  Player(this.stones);

  void moveStone(Stone stone, Position position) => stone.move(position);
}
