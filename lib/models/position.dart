// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'stone.dart';

class Position {
  List<Position> adjacentPositions;
  Stone? stone;

  Position(this.adjacentPositions);

  Position copyWith({
    List<Position>? adjacentPositions,
    Stone? stone,
  }) {
    return Position(adjacentPositions ?? this.adjacentPositions);
  }
}
