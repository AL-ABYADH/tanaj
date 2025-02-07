import 'position.dart';

class Board {
  late final List<List<Position>> positions;

  Board() {
    final pos0 = Position([]);
    final pos1 = Position([]);
    final pos2 = Position([]);
    final pos3 = Position([]);
    final pos4 = Position([]);
    final pos5 = Position([]);
    final pos6 = Position([]);
    final pos7 = Position([]);
    final pos8 = Position([]);

    pos0.adjacentPositions = [pos1, pos3, pos4];
    pos1.adjacentPositions = [pos0, pos2, pos4];
    pos2.adjacentPositions = [pos1, pos5, pos4];
    pos3.adjacentPositions = [pos0, pos4, pos6];
    pos4.adjacentPositions = [pos0, pos1, pos2, pos3, pos5, pos6, pos7, pos8];
    pos5.adjacentPositions = [pos2, pos4, pos8];
    pos6.adjacentPositions = [pos3, pos4, pos7];
    pos7.adjacentPositions = [pos4, pos6, pos8];
    pos8.adjacentPositions = [pos4, pos5, pos7];

    positions = [
      [pos0, pos1, pos2],
      [pos3, pos4, pos5],
      [pos6, pos7, pos8]
    ];
  }
}
