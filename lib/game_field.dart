import 'package:flutter/material.dart';

class GameField extends StatelessWidget {
  const GameField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _GameFieldPainter(pointsBySize: 100),
    );
  }
}

class _GameFieldPainter extends CustomPainter {
  const _GameFieldPainter({required this.pointsBySize});

  final int pointsBySize;

  @override
  void paint(Canvas canvas, Size size) {
    _drawDebugPoints(canvas, size);
    //canvas.po
    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height),
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawDebugPoints(Canvas canvas, Size size) {
    final squareSize = size.shortestSide;
    final step = squareSize / pointsBySize;
    final offset = step / 2;
    const dotRadius = 1.0;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    final generalOffset = squareSize / 2;

    for (int i = 0; i < pointsBySize; i++) {
      for (int j = 0; j < pointsBySize; j++) {
        final dx = step * i + offset - dotRadius - generalOffset;
        final dy = step * j + offset - dotRadius - generalOffset;

        canvas.drawCircle(size.center(Offset(dx, dy)), dotRadius, paint);
      }
    }
  }
}
