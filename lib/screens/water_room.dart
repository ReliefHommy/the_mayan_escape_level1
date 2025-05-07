import 'package:flutter/material.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';
import 'package:mayan_level1/puzzles/puzzle_popup.dart';
import 'package:mayan_level1/puzzles/puzzle_pressure_plate.dart';
import 'package:mayan_level1/puzzles/puzzle_water_offer.dart';
import 'package:provider/provider.dart';

class WaterRoom extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  WaterRoom({super.key});

  @override
  State<WaterRoom> createState() => _WaterRoomState();
}

//
class _WaterRoomState extends State<WaterRoom> {
  String? selectedPuzzle;
  final List<String> requiredItems = [
    'Water Basin',
    'Hidden Passage Key',
  ];

  bool hasAllRequiredItems(BuildContext context) {
    final gameState = context.watch<GameStateManager>();
    return requiredItems.every(gameState.hasItem);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<GameStateManager>();
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('assets/images/water_offer_room.jpg', //
                fit: BoxFit.cover),
          ),

          // Inventory -- Water Basin--Poor the watter to activate Golden key

          Positioned(
            top: 500,
            left: 380,
            child: Tooltip(
              message: "Water Basin",
              child: GestureDetector(
                onTap: () {
                  //To DO:selectedPuzzle = 'water_offering';
                  showDialog(
                    context: context,
                    builder: (_) => WaterPuzzle(onSolved: () {
                      // maybe unlock new scene or visual
                    }),
                  );
                  context.read<GameStateManager>().collectItem('Water Basin');
                  context
                      .read<GameStateManager>()
                      .markPuzzleAsSolved('water_offering');
                },
                child: Image.asset(
                  'assets/icons/water_basin.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),

          // Inventory -- Hidden Passage Key--
          if (context
              .watch<GameStateManager>()
              .isPuzzleSolved('water_offering'))
            Positioned(
              top: 450,
              left: 50,
              child: Tooltip(
                message: "Hidden passed Key",
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => PuzzlePressurePlate(onSolved: () {
                        // maybe unlock new scene or visual
                      }),
                    );
                    //To DO:selectedPuzzle  -pressure_plate_puzzle--
                    context
                        .read<GameStateManager>()
                        .collectItem('Hidden Passage Key');
                  },
                  child: Image.asset(
                    'assets/icons/hidden_passage_key.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),

//Transite to Final Scene-Final Puzzle

          //  Inventory Bar at the Bottom

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    context.watch<GameStateManager>().inventory.map((item) {
                  final iconPath = widget.inventoryIcons[item] ??
                      'assets/icons/${item.toLowerCase().replaceAll(" ", "_")}.png';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.brown, width: 2),
                      ),
                      child: Image.asset(
                        iconPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (selectedPuzzle != null)
            //PuzzlePopup
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: PuzzlePopup(
                    puzzleTitle: selectedPuzzle!,
                    onClose: () {
                      setState(() {
                        selectedPuzzle = null;
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
//
