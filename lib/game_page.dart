import 'package:flutter/material.dart';
import 'package:flutter_snake/game_field.dart';
import 'package:flutter_snake/game_layout.dart';
import 'package:flutter_snake/game_top_bar.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  void action() {}

  @override
  Widget build(BuildContext context) {
    return GameLayout(
      title: "SmallBossGames' Snake", 
      topBar: GameTopBar(score: 12, whenReset: action), 
      gameField: const GameField(pointsBySize: 50, rawApplePoint: [9,9], rawLinePoints: [1,1,1,2,1,3]));
  }
}
