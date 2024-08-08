import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sudoku/colors/colors.dart';

/// {@template sudoku_background}
/// Builds the background of the Sudoku app.
///
/// Renders [GradientBackground] along with a [BackdropFilter]
/// inside a [Stack] to facilitate the blur effect.
/// {@endtemplate}
class SudokuBackground extends StatelessWidget {
  /// {@macro sudoku_background}
  const SudokuBackground({required this.child, super.key});

  /// Widget to be rendered above the background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: GradientBackground(
            child: SizedBox(
              width: 520,
              child: AspectRatio(
                aspectRatio: 1155 / 678,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Transform.rotate(
            angle: 30.0 * pi / 180, // Rotate second shape
            child: const GradientBackground(
              child: SizedBox(
                width: 620,
                child: AspectRatio(
                  aspectRatio: 1155 / 678,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 65, sigmaY: 65),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
        ),
        child,
      ],
    );
  }
}

/// {@template gradient_background}
/// Widget to create [CustomPaint] with [GradientBackgroundPainter] painter.
/// {@endtemplate}
@visibleForTesting
class GradientBackground extends StatelessWidget {
  /// {@macro gradient_background}
  const GradientBackground({required this.child, super.key});

  /// Child of the [CustomPaint].
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientBackgroundPainter(context: context),
      child: child,
    );
  }
}

/// {@template gradient_background_painter}
/// Creates the shape used for the background for the Sudoku app.
///
/// Extends [CustomPainter].
/// {@endtemplate}
@visibleForTesting
class GradientBackgroundPainter extends CustomPainter {
  /// {@macro gradient_background_painter}
  GradientBackgroundPainter({
    required this.context,
  });

  final BuildContext context;
  final Paint _paint = Paint();

  List<Color> get colors {
    return [
      SudokuColors.getPurpleBackground(context),
      SudokuColors.getPinkBackground(context),
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path1 = Path()
      ..moveTo(size.width * 0.741, size.height * 0.441)
      ..lineTo(size.width, size.height * 0.616)
      ..lineTo(size.width * 0.975, size.height * 0.269)
      ..lineTo(size.width * 0.855, size.height * 0.01)
      ..lineTo(size.width * 0.807, size.height * 0.2)
      ..lineTo(size.width * 0.725, size.height * 0.325)
      ..lineTo(size.width * 0.602, size.height * 0.624)
      ..lineTo(size.width * 0.524, size.height * 0.681)
      ..lineTo(size.width * 0.475, size.height * 0.583)
      ..lineTo(size.width * 0.452, size.height * 0.345)
      ..lineTo(size.width * 0.275, size.height * 0.767)
      ..lineTo(size.width * 0.01, size.height * 0.649)
      ..lineTo(size.width * 0.179, size.height)
      ..lineTo(size.width * 0.276, size.height * 0.768)
      ..lineTo(size.width * 0.761, size.height * 0.977)
      ..lineTo(size.width * 0.741, size.height * 0.441)
      ..close();

    _paint.shader = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: colors,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path1, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
