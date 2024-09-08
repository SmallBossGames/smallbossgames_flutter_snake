import 'package:flutter/material.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({super.key, required this.score, required this.whenReset});

  final int score;
  
  final VoidCallback whenReset;

  void action() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(onPressed: whenReset, child: const Text("Reset")),
            Text("Score: $score")
          ],
        )
      ],
    );
  }
}
