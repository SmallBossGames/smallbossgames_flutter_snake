import 'dart:ui';

import 'package:flutter/material.dart';

class GameField extends StatelessWidget {
  const GameField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _GameFieldPainter(
          pointsBySize: 50,
          applePoint: [9, 9],
          rawLinePoints: [2, 2, 2, 3, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 3, 8]),
    );
  }
}

class _GameFieldPainter extends CustomPainter {
  const _GameFieldPainter(
      {required this.pointsBySize,
      required this.rawLinePoints,
      required this.applePoint});

  final int pointsBySize;
  final List<int> applePoint;
  final List<int> rawLinePoints;

  @override
  void paint(Canvas canvas, Size size) {
    _drawDebugPoints(canvas, size);
    _drawSnake(canvas, size);
    _drawApple(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawSnake(Canvas canvas, Size size) {
    final squareSize = size.shortestSide;
    final step = squareSize / pointsBySize;
    final offset = step / 2;
    final generalOffset = squareSize / 2;

    final snakePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final snakeHeadPaint = Paint()
      ..color = Colors.orange.shade700
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final line = List<Offset>.empty(growable: true);
    final path = Path();

    for (var i = 0; i < rawLinePoints.length; i += 2) {
      if (i > 0) {
        final x1 = rawLinePoints[i - 2];
        final x2 = rawLinePoints[i];
        final y1 = rawLinePoints[i - 1];
        final y2 = rawLinePoints[i + 1];

        final sqaredDistance = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);

        if (sqaredDistance > 1) {
          path.addPolygon(line, false);

          line.clear();
        }
      }

      final dx = step * rawLinePoints[i] + offset - generalOffset;
      final dy = step * rawLinePoints[i + 1] + offset - generalOffset;

      line.add(size.center(Offset(dx, dy)));
    }

    path.addPolygon(line, false);

    canvas.drawPath(path, snakePaint);
    canvas.drawPoints(PointMode.points, [line.last], snakeHeadPaint);
  }

  void _drawApple(Canvas canvas, Size size) {
    final squareSize = size.shortestSide;
    final step = squareSize / pointsBySize;
    final offset = step / 2;
    final generalOffset = squareSize / 2;

    final applePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    final dx = step * applePoint[0] + offset - generalOffset;
    final dy = step * applePoint[1] + offset - generalOffset;

    canvas.drawPoints(PointMode.points, [size.center(Offset(dx, dy))], applePaint);
  }

  void _drawDebugPoints(Canvas canvas, Size size) {
    final squareSize = size.shortestSide;
    final step = squareSize / pointsBySize;
    final offset = step / 2;

    final debugPointPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final generalOffset = squareSize / 2;

    var points = List<Offset>.empty(growable: true);

    for (int i = 0; i < pointsBySize; i++) {
      for (int j = 0; j < pointsBySize; j++) {
        final dx = step * i + offset - generalOffset;
        final dy = step * j + offset - generalOffset;

        points.add(size.center(Offset(dx, dy)));
      }
    }

    canvas.drawPoints(PointMode.points, points, debugPointPaint);
  }
}
