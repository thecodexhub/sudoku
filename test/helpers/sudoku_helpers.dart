import 'package:sudoku/models/models.dart';

const sudoku2x2Block0 = Block(
  position: Position(x: 0, y: 0),
  correctValue: 4,
  currentValue: -1,
);

const sudoku2x2Block1 = Block(
  position: Position(x: 0, y: 1),
  correctValue: 1,
  currentValue: 1,
  isGenerated: true,
);

const sudoku2x2Block2 = Block(
  position: Position(x: 0, y: 2),
  correctValue: 2,
  currentValue: -1,
);

const sudoku2x2Block3 = Block(
  position: Position(x: 0, y: 3),
  correctValue: 3,
  currentValue: -1,
);

const sudoku2x2Block4 = Block(
  position: Position(x: 1, y: 0),
  correctValue: 2,
  currentValue: 2,
  isGenerated: true,
);

const sudoku2x2Block5 = Block(
  position: Position(x: 1, y: 1),
  correctValue: 3,
  currentValue: 3,
  isGenerated: true,
);

const sudoku2x2Block6 = Block(
  position: Position(x: 1, y: 2),
  correctValue: 4,
  currentValue: -1,
);

const sudoku2x2Block7 = Block(
  position: Position(x: 1, y: 3),
  correctValue: 1,
  currentValue: -1,
);

const sudoku2x2Block8 = Block(
  position: Position(x: 2, y: 0),
  correctValue: 1,
  currentValue: -1,
);

const sudoku2x2Block9 = Block(
  position: Position(x: 2, y: 1),
  correctValue: 4,
  currentValue: -1,
);

const sudoku2x2Block10 = Block(
  position: Position(x: 2, y: 2),
  correctValue: 3,
  currentValue: 3,
  isGenerated: true,
);

const sudoku2x2Block11 = Block(
  position: Position(x: 2, y: 3),
  correctValue: 2,
  currentValue: 2,
  isGenerated: true,
);

const sudoku2x2Block12 = Block(
  position: Position(x: 3, y: 0),
  correctValue: 3,
  currentValue: -1,
);

const sudoku2x2Block13 = Block(
  position: Position(x: 3, y: 1),
  correctValue: 2,
  currentValue: -1,
);

const sudoku2x2Block14 = Block(
  position: Position(x: 3, y: 2),
  correctValue: 1,
  currentValue: 1,
  isGenerated: true,
);

const sudoku2x2Block15 = Block(
  position: Position(x: 3, y: 3),
  correctValue: 4,
  currentValue: -1,
);

const sudoku2x2 = Sudoku(
  blocks: [
    sudoku2x2Block0,
    sudoku2x2Block1,
    sudoku2x2Block2,
    sudoku2x2Block3,
    sudoku2x2Block4,
    sudoku2x2Block5,
    sudoku2x2Block6,
    sudoku2x2Block7,
    sudoku2x2Block8,
    sudoku2x2Block9,
    sudoku2x2Block10,
    sudoku2x2Block11,
    sudoku2x2Block12,
    sudoku2x2Block13,
    sudoku2x2Block14,
    sudoku2x2Block15,
  ],
);

final sudoku2x2WithOneRemaining = sudoku2x2
    .updateBlock(sudoku2x2Block0, 4)
    .updateBlock(sudoku2x2Block3, 3)
    .updateBlock(sudoku2x2Block6, 4)
    .updateBlock(sudoku2x2Block7, 1)
    .updateBlock(sudoku2x2Block8, 1)
    .updateBlock(sudoku2x2Block9, 4)
    .updateBlock(sudoku2x2Block12, 3)
    .updateBlock(sudoku2x2Block13, 2)
    .updateBlock(sudoku2x2Block15, 4);
