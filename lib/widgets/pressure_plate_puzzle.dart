import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/screens/final_mayan.dart';
import '../game_state_maneger.dart';

class PressurePlatePuzzle extends StatefulWidget {
  final VoidCallback onSolved;

  const PressurePlatePuzzle({required this.onSolved, super.key});

  @override
  _PressurePlatePuzzleState createState() => _PressurePlatePuzzleState();
}

class _PressurePlatePuzzleState extends State<PressurePlatePuzzle> {
  final List<String> correctItems = [
    "Feathered Serpent Statue",
    "Hidden Passage Key",
    "Passed Key"
  ];
  List<String> placedItems = [];

  @override
  Widget build(BuildContext context) {
    final inventory = context.watch<GameStateManager>().inventory;
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
        "Place the Artifacts",
        style: TextStyle(
          fontFamily: 'CinzelDecorative',
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Place the correct artifacts on the stone pedestals to unlock the door.",
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'DM_Sans',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: inventory.map((item) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (!placedItems.contains(item) && placedItems.length < 3) {
                      placedItems.add(item);
                    }

                    final solved = placedItems.length == correctItems.length &&
                        placedItems.toSet().containsAll(correctItems);

                    if (solved) {
                      context
                          .read<GameStateManager>()
                          .markPuzzleAsSolved('pressure_plate');
                      widget.onSolved();
                      Navigator.pop(context); // Close puzzle popup
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MayanFinalScene()),
                      );
                    }
                  });
                },
                child: Chip(
                  label: Text(item),
                  backgroundColor:
                      placedItems.contains(item) ? Colors.orange : Colors.white,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 12),
          Text(
            placedItems.length == 3 &&
                    !placedItems.toSet().containsAll(correctItems)
                ? "Incorrect items placed. Try again!"
                : "",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
