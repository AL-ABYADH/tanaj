import 'position.dart';

class Board {
  late final List<List<Position>> positions;

  Board() {
    positions = List.generate(
      3,
      (row) => List.generate(
        3,
        (col) => Position([], row, col),
      ),
    );

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final pos = positions[row][col];
        if (row > 0) {
          pos.adjacentPositions.add(positions[row - 1][col]);
        }
        if (row < 2) {
          pos.adjacentPositions.add(positions[row + 1][col]);
        }
        if (col > 0) {
          pos.adjacentPositions.add(positions[row][col - 1]);
        }
        if (col < 2) {
          pos.adjacentPositions.add(positions[row][col + 1]);
        }
      }
    }
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
