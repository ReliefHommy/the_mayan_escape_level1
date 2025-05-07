import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';

class StoneDialPuzzle extends StatefulWidget {
  final VoidCallback onSolved;

  const StoneDialPuzzle({required this.onSolved, super.key});

  @override
  _StoneDialPuzzleState createState() => _StoneDialPuzzleState();
}

class _StoneDialPuzzleState extends State<StoneDialPuzzle> {
  int rotationIndex = 0;
  final List<String> symbols = ["🌞", "🌙", "🦅", "🐍"];
  final String correctSymbol = "🦅"; // Correct alignment to unlock

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Rotate the Stone Dial"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(symbols[rotationIndex], style: TextStyle(fontSize: 40)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // 1. Mark the puzzle as solved globally
              context
                  .read<GameStateManager>()
                  .markPuzzleAsSolved('rotating_stone_dial');
              // 2. Close the current puzzle dialog
              Navigator.pop(context);
              // 3. Navigate to a scene that contains GlowEffectWidget
            },
            child: Text("Rotate"),
          ),
        ],
      ),
    );
  }
}
