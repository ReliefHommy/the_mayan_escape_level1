import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/effects/water_hint.dart';
import 'package:mayan_level1/puzzle_popup.dart';
import '../../../game_state_maneger.dart';
import '../../../widgets/pressure_plate_puzzle.dart';
import '../../../widgets/water_offer_puzzle_widget_ai.dart';

class WaterPuzzleRoomScreen extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  WaterPuzzleRoomScreen({super.key});

  @override
  State<WaterPuzzleRoomScreen> createState() => _WaterPuzzleRoomScreenState();
}

class _WaterPuzzleRoomScreenState extends State<WaterPuzzleRoomScreen> {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    context.watch<GameStateManager>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background  desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/water_intro_bg.png', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scenes
          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 800,
            child: Image.asset(
              'assets/images/water_intro_bg.png', //
              fit: BoxFit.cover,
            ),
          ))),

          // Inventory -- Water Basin--Poor the watter to activate Golden key

          Positioned(
            top: screenHeight * 0.60,
            left: screenWidth * 0.25,
            child: Tooltip(
              message: "A Water Basin!",
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/icons/water_basin_bg.png',
                      width: 80,
                      height: 80,
                    ),
                  )),
            ),
          ),

          // Inventory -- Hidden Passage Key--
          Positioned(
            top: screenHeight * 0.10,
            left: screenWidth * 0.65,
            child: Column(
              children: [WaterHint()],
            ),
          ),
          if (context
              .watch<GameStateManager>()
              .isPuzzleSolved('water_offering'))
            Positioned(
              top: screenHeight * 0.10,
              left: screenWidth * 0.50,
              child: Tooltip(
                message: "Hidden Passage Key!",
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => PressurePlatePuzzle(onSolved: () {
                          // maybe unlock new scene or visual
                        }),
                      );
                      //To DO:selectedPuzzle  -pressure_plate_puzzle--
                      context
                          .read<GameStateManager>()
                          .collectItem('Hidden Passage Key');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/icons/hidden_passed_key_bg.png',
                        width: 80,
                        height: 80,
                      ),
                    )),
              ),
            ),

//Transite to Final Scene-Final Puzzle

          //  Inventory Bar at the Bottom

          Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Tooltip(
                message:
                    "The Unusual Golden Water Basin-There're the key behide it!",
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
              )),
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
