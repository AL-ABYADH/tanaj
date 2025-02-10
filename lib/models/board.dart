import 'position.dart';

class Board {
  late final List<List<Position>> positions;

  Board() {
    final pos0 = Position([], 0, 0);
    final pos1 = Position([], 0, 1);
    final pos2 = Position([], 0, 2);
    final pos3 = Position([], 1, 0);
    final pos4 = Position([], 1, 1);
    final pos5 = Position([], 1, 2);
    final pos6 = Position([], 2, 0);
    final pos7 = Position([], 2, 1);
    final pos8 = Position([], 2, 2);

    pos0.adjacentPositions = [pos1, pos3, pos4];
    pos1.adjacentPositions = [pos0, pos2, pos4];
    pos2.adjacentPositions = [pos1, pos5, pos4];
    pos3.adjacentPositions = [pos0, pos4, pos6];
    pos4.adjacentPositions = [pos0, pos1, pos2, pos3, pos5, pos6, pos7, pos8];
    pos5.adjacentPositions = [pos2, pos4, pos8];
    pos6.adjacentPositions = [pos3, pos4, pos7];
    pos7.adjacentPositions = [pos4, pos6, pos8];
    pos8.adjacentPositions = [pos4, pos5, pos7];

    positions = List<List<Position>>.unmodifiable([
      List<Position>.unmodifiable([pos0, pos1, pos2]),
      List<Position>.unmodifiable([pos3, pos4, pos5]),
      List<Position>.unmodifiable([pos6, pos7, pos8]),
    ]);
  }

  List<int> getPositionIndex(Position position) {
    for (int row = 0; row < positions.length; row++) {
      for (int col = 0; col < positions[row].length; col++) {
        if (positions[row][col] == position) {
          return [row, col];
        }
      }
    }
    return [-1, -1];
  }
}
