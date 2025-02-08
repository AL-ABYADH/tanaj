import 'stone.dart';

class Player {
  final String name;
  final List<Stone> stones;

  Player(this.name, this.stones);

  @override
  String toString() => 'Player(name: $name, stones: $stones)';
}
