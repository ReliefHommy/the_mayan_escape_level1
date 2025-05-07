import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/level_complete.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';

class PuzzlePressurePlate extends StatefulWidget {
  final VoidCallback onSolved;
//PuzzlePressurePlate
  const PuzzlePressurePlate({required this.onSolved, super.key});

  @override
  _PuzzlePressurePlateState createState() => _PuzzlePressurePlateState();
}

class _PuzzlePressurePlateState extends State<PuzzlePressurePlate> {
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
      title: Text("Place the Artifacts"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Place the correct artifacts on the stone pedestals to unlock the door."),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
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
                        MaterialPageRoute(builder: (_) => LevelComplete()),
                      );
                    }
                  });
                },
                child: Chip(
                  label: Text(item),
                  backgroundColor:
                      placedItems.contains(item) ? Colors.green : Colors.grey,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text(placedItems.length == 3 &&
                  !placedItems.toSet().containsAll(correctItems)
              ? "Incorrect items placed. Try again!"
              : ""),
        ],
      ),
    );
  }
}
