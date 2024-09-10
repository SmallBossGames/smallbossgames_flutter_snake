import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

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
  static final random = Random();

  static const _defaultSnakePoints = [1, 1, 1, 2];

  var _rawApplePoint = _createApple(_defaultSnakePoints);
  var _rawLinePoints = _defaultSnakePoints;
  var _score = 0;
  var direction = Direction.down;
  var newDirection = Direction.down;

  late Timer _mainLoopTimer;

  void _handleKey(KeyEvent a) {
    final key = a.logicalKey;

    if (key == LogicalKeyboardKey.arrowUp && direction != Direction.down) {
      newDirection = Direction.up;
    } else if (key == LogicalKeyboardKey.arrowDown &&
        direction != Direction.up) {
      newDirection = Direction.down;
    } else if (key == LogicalKeyboardKey.arrowLeft &&
        direction != Direction.right) {
      newDirection = Direction.left;
    } else if (key == LogicalKeyboardKey.arrowRight &&
        direction != Direction.left) {
      newDirection = Direction.right;
    }
  }

  static List<int> _createApple(List<int> snakePoints) {
    var exculsionPoints = Int32List((snakePoints.length ~/ 2));
    for (var i = 0; i < snakePoints.length; i+=2) {
      exculsionPoints[(i ~/ 2)] =
          snakePoints[i] + snakePoints[i + 1] * 50;
    }
    exculsionPoints.sort();

    var nextPoint = random.nextInt(50 * 50 - exculsionPoints.length);
    for(var i = 0; i < exculsionPoints.length; i++){
      if(exculsionPoints[i] <= nextPoint){
        nextPoint++;
      }
    }

    return [nextPoint % 50, nextPoint ~/50];
  }

  @override
  void initState() {
    super.initState();

    _mainLoopTimer = Timer.periodic(const Duration(milliseconds: 100), (x) {
      direction = newDirection;

      final headPosition = _rawLinePoints.sublist(_rawLinePoints.length - 2);

      if (headPosition[0] == _rawApplePoint[0] &&
          headPosition[1] == _rawApplePoint[1]) {
        setState(() {
          _score++;
          _rawLinePoints = [
            ..._rawLinePoints,
            (headPosition[0] + direction.x) % 50,
            (headPosition[1] + direction.y) % 50,
          ];
          _rawApplePoint = _createApple(_rawLinePoints);
        });
      }

      setState(() {
        _rawLinePoints = [
          ..._rawLinePoints.sublist(2),
          (headPosition[0] + direction.x) % 50,
          (headPosition[1] + direction.y) % 50
        ];
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
            topBar: GameTopBar(score: _score, whenReset: widget.whenReset),
            gameField: GameField(
                pointsBySize: 50,
                rawApplePoint: _rawApplePoint,
                rawLinePoints: _rawLinePoints)));
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _mainLoopTimer.cancel();
  }
}

enum Direction {
  up(x: 0, y: -1),
  down(x: 0, y: 1),
  left(x: -1, y: 0),
  right(x: 1, y: 0);

  const Direction({required this.x, required this.y});

  final int x;
  final int y;
}
