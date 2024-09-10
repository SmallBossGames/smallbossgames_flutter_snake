import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake/game_field.dart';
import 'package:flutter_snake/game_layout.dart';
import 'package:flutter_snake/game_top_bar.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  var _refreshKey = UniqueKey();

  void _resetRefreshKey() {
    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _GamePageInternal(key: _refreshKey, whenReset: _resetRefreshKey);
  }
}

class _GamePageInternal extends StatefulWidget {
  const _GamePageInternal({super.key, required this.whenReset});

  final VoidCallback whenReset;

  @override
  State<StatefulWidget> createState() => _GamePageInternalState();
}

class _GamePageInternalState extends State<_GamePageInternal> {
  final _focusNode = FocusNode();

  var rawApplePoint = [Random().nextInt(50), Random().nextInt(50)];
  var rawLinePoints = [1, 1, 1, 2, 1, 3];
  var direction = Direction.down;
  var newDirection = Direction.down;

  late Timer _mainLoopTimer;

  void _handleKey(KeyEvent a) {
    final key = a.logicalKey;

    if (key == LogicalKeyboardKey.arrowUp && direction != Direction.down) {
      newDirection = Direction.up;
    } else if (key == LogicalKeyboardKey.arrowDown && direction != Direction.up) {
      newDirection = Direction.down;
    } else if (key == LogicalKeyboardKey.arrowLeft && direction != Direction.right) {
      newDirection = Direction.left;
    } else if (key == LogicalKeyboardKey.arrowRight && direction != Direction.left) {
      newDirection = Direction.right;
    }
  }

  @override
  void initState() {
    super.initState();

    _mainLoopTimer = Timer.periodic(const Duration(milliseconds: 100), (x) {
      direction = newDirection;

      final newLinePoints = [
        ...rawLinePoints.sublist(2), 
        (rawLinePoints[rawLinePoints.length - 2] + direction.x) % 50,
        (rawLinePoints[rawLinePoints.length - 1] + direction.y) % 50,
      ];

      setState(() {
        rawLinePoints = newLinePoints;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKey,
        child: GameLayout(
            title: "SmallBossGames' Snake",
            topBar: GameTopBar(score: 12, whenReset: widget.whenReset),
            gameField: GameField(
                pointsBySize: 50,
                rawApplePoint: rawApplePoint,
                rawLinePoints: rawLinePoints)));
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _mainLoopTimer.cancel();
  }
}

enum Direction{
  up(x: 0, y: -1),
  down(x: 0, y: 1), 
  left(x: -1, y: 0),
  right(x: 1, y: 0);

  const Direction({required this.x, required this.y});

  final int x;
  final int y;
}
