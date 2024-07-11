import 'package:flutter/material.dart';

/// {@template sudoku_icon}
/// Custom widget that renders icon asset in a designed layout.
/// {@endtemplate}
class SudokuIcon extends StatelessWidget {
  /// {@macro sudoku_icon}
  const SudokuIcon({
    required this.iconAsset,
    this.scaleFactor = 1,
    super.key,
  });

  /// Icon from the assets.
  final String iconAsset;

  /// Defines the scale factor of the widget.
  ///
  /// Will be multiplied with the [Container] sides and image asset sides.
  ///
  /// Default is 1. And it creates a container of side as 48, and icon asset
  /// with size of 32.
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48 * scaleFactor,
      width: 48 * scaleFactor,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.6),
      ),
      child: Image.asset(
        iconAsset,
        height: 32 * scaleFactor,
        width: 32 * scaleFactor,
      ),
    );
  }
}
