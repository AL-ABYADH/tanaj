import 'position.dart';

class Stone {
  Position position;

  Stone(this.position);

  void move(Position position) {
    this.position.stone = null;
    this.position = position;
    this.position.stone = this;
  }
}
