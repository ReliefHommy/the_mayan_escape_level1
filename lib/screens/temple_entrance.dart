import 'package:flutter/material.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';
import 'package:mayan_level1/puzzles/puzzle_rotate_stone.dart';
import 'package:mayan_level1/widgets/temple_entrance_widget.dart';
import 'package:provider/provider.dart';

class TempleEntrance extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  TempleEntrance({super.key});

  @override
  State<TempleEntrance> createState() => _TempleEntranceState();
}

class _TempleEntranceState extends State<TempleEntrance> {
  String? selectedPuzzle;
  final List<String> requiredItems = [];
  bool hasAllRequiredItems(BuildContext context) {
    final gameState = context.watch<GameStateManager>();
    return requiredItems.every(gameState.hasItem);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/temple_entrance.jpg', // Your background image
              //width: 565,
              //height: 870,
              fit: BoxFit.cover,
            ),
          ),

          // ---Rotating Stone Dial--

          Positioned(
            //top: 400,
            //left: 150,
            top: screenHeight * 0.40, // 40% from the top
            left: screenWidth * 0.15, // 15% from the left
            child: Tooltip(
              message: "Rotating Stone Dial to Open the Door! ",
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => StoneDialPuzzle(onSolved: () {
                            context
                                .read<GameStateManager>()
                                .markPuzzleAsSolved('rotating_stone_dial');
                          }));
                },
                child: Image.asset(
                  'assets/icons/rotating_stone.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),

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
          if (context
              .watch<GameStateManager>()
              .isPuzzleSolved('rotating_stone_dial'))
            Positioned.fill(
              top: 200,
              left: 100,
              child: Column(
                children: [
                  TempleEntranceWidget(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
