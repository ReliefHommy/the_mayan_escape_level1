import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game_state_maneger.dart'; // adjust path if needed

class GlyphPuzzleWidget extends StatefulWidget {
  final VoidCallback onSolved;

  const GlyphPuzzleWidget({super.key, required this.onSolved});

  @override
  State<GlyphPuzzleWidget> createState() => _GlyphPuzzleWidgetState();
}

class _GlyphPuzzleWidgetState extends State<GlyphPuzzleWidget> {
  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameStateManager>();
    final glyphs = gameState.correctGlyphOrder; // could be dynamic in future
    final userOrder = gameState.userGlyphOrder;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tap the glyphs in the correct order",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'CinzelDecorative',
              color: Colors.black,
              //shadows: [Shadow(blurRadius: 2, color: Colors.brown)],
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: glyphs.map((glyph) {
              final isSelected = userOrder.contains(glyph);

              return GestureDetector(
                onTap: () {
                  context.read<GameStateManager>().tapGlyph(glyph, () {
                    widget.onSolved();
                    Navigator.pop(context); // Close puzzle
                  });
                },
                child: Chip(
                  label: Text(glyph,
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  backgroundColor: isSelected ? Colors.grey : Colors.brown,
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
      ),
    );
  }
}
