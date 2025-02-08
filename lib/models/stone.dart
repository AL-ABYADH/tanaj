// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'position.dart';

class Stone {
  int id;
  Position position;

  Stone(this.id, this.position);

  void move(Position position) {
    this.position.stone = null;
    this.position = position;
    this.position.stone = this;
  }
}
