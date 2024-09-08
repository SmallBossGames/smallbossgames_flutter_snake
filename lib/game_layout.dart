import 'package:flutter/material.dart';
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
            child: GameTopBar(score: 12, whenReset: action)
          ),
        ),
      ),
    );
  }
}
