import 'package:flutter/material.dart';
import 'package:flutter_snake/game_field.dart';
import 'package:flutter_snake/game_top_bar.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({super.key, required this.title});

  final String title;

  static void action() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
              child: GameTopBar(score: 12, whenReset: action)),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: GameField(pointsBySize: 50, rawApplePoint: [
            9,
            9
          ], rawLinePoints: [
            2,
            2,
            2,
            3,
            3,
            3,
            3,
            4,
            3,
            5,
            3,
            6,
            3,
            7,
            3,
            8
          ]))
        ]),
      ),
    );
  }
}
