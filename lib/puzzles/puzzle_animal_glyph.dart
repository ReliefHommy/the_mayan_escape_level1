import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';

class GlyphPuzzleWidget extends StatelessWidget {
  final VoidCallback onSolved;

  const GlyphPuzzleWidget({super.key, required this.onSolved});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameStateManager>();
    final glyphs = gameState.correctGlyphOrder; // could be dynamic in future

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Tap the glyphs in the correct order",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 12,
          children: glyphs.map((glyph) {
            final isTapped = gameState.userGlyphOrder.contains(glyph);

            return GestureDetector(
              onTap: () {
                if (!isTapped) {
                  context.read<GameStateManager>().tapGlyph(glyph, () {
                    onSolved();
                    Navigator.pop(context); // Close puzzle
                  });
                }
              },
              child: Chip(
                label: Text(glyph, style: TextStyle(fontSize: 30)),
                backgroundColor: isTapped ? Colors.grey : Colors.orange,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        if (gameState.userGlyphOrder.isNotEmpty)
          ElevatedButton(
            onPressed: () {
              context.read<GameStateManager>().resetGlyphPuzzle();
            },
            child: Text("Reset"),
          ),
      ],
    );
  }
}
