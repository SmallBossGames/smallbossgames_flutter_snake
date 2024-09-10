import 'package:flutter/material.dart';

class GameLayout extends StatelessWidget {
  const GameLayout(
      {super.key,
      required this.title,
      required this.topBar,
      required this.gameField});

  final String title;
  final Widget topBar;
  final Widget gameField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
              child: topBar),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Expanded(child: gameField)]),
      ),
    );
  }
}
