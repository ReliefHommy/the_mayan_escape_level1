import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/game_state_maneger.dart';
import 'package:mayan_level1/text_style.dart';

class StoneDialPuzzle extends StatefulWidget {
  final VoidCallback onSolved;

  const StoneDialPuzzle({required this.onSolved, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StoneDialPuzzleState createState() => _StoneDialPuzzleState();
}

class _StoneDialPuzzleState extends State<StoneDialPuzzle> {
  int rotationIndex = 0;
  final List<String> symbols = ['☀️', '🌙', '🔥', '🌿'];
  final String correctSymbol = "🌿"; // Correct alignment to unlock

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.brown.withOpacity(0.5),
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 40), // Adds more spacing to top/bottom
      contentPadding: const EdgeInsets.fromLTRB(
          20, 20, 20, 30), // Add space inside the box at bottom
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.brown.shade300, width: 2),
      ),
      title: Text(
        "Rotate the Stone Dial",
        style: subHeadingTextStyle,
        textAlign: TextAlign.center,
      ),
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
              rotationIndex = (rotationIndex + 1) % symbols.length;
              // 2. Close the current puzzle dialog
              Navigator.pop(context);
              if (symbols[rotationIndex] == correctSymbol) {
                widget.onSolved();
                Navigator.pop(context);
              }
              // 3. Navigate to a scene that contains GlowEffectWidget
            },
            child: Text(
              "Rotate",
              style: elevatedButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
