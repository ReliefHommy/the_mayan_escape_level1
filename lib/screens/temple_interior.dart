import 'package:flutter/material.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';
import 'package:mayan_level1/puzzles/puzzle_animal_glyph.dart';
import 'package:mayan_level1/widgets/enter_water_area_widget.dart';
import 'package:provider/provider.dart';

class TempleInterior extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  TempleInterior({super.key});

  @override
  State<TempleInterior> createState() => _TempleInteriorState();
}

//
class _TempleInteriorState extends State<TempleInterior> {
  String? selectedPuzzle;
  final List<String> requiredItems = ['Passed Key', 'Water Hold Only'];
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
      body: Stack(
        children: [
          // Scene Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/temple_interior_glyphs.jpg',
              width: 565,
              //height: 870,
              fit: BoxFit.cover,
            ),
          ),
          //   3-Inventory ---Hidden Passage Key---after Glyph puzzle solved!
          if (context.watch<GameStateManager>().isPuzzleSolved('animal_glyph'))
            Positioned(
              top: screenHeight * 0.30, // 30% from the top
              left: screenWidth * 0.10, // 10% from the left
              //top: 300,
              //left: 80,
              child: Tooltip(
                message: "Passed Key",
                child: GestureDetector(
                  onTap: () {
                    context.read<GameStateManager>().collectItem('Passed Key');
                  },
                  child: Image.asset(
                    'assets/icons/passed_key.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
// Water blow appearen when the golden key kollected!
          //   4-Inventory ---Water Bowl---
          if (context.watch<GameStateManager>().hasItem('Passed Key'))
            Positioned(
              top: screenHeight * 0.50, // 30% from the top
              left: screenWidth * 0.18, // 10% from the left
              //top: 500,
              //left: 180,
              child: Tooltip(
                message: "Water Holder",
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<GameStateManager>()
                        .collectItem('Water Hold Only');
                  },
                  child: Image.asset(
                    'assets/icons/water_hold_only.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),

          // ---Animal Glyph Puzzle--
          // Only show the icon if the puzzle is NOT solved yet
          if (!context.watch<GameStateManager>().isPuzzleSolved('animal_glyph'))
            Positioned(
              top: screenHeight * 0.34, // 30% from the top
              left: screenWidth * 0.30, // 10% from the left
              //top: 340,
              //left: 300,
              child: Tooltip(
                message: "Animal Glyph Puzzle",
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        content: GlyphPuzzleWidget(
                          onSolved: () {
                            context
                                .read<GameStateManager>()
                                .markPuzzleAsSolved('animal_glyph');
                          },
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/animal_glyph.png',
                    width: 50,
                    height: 50,
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
          if (hasAllRequiredItems(context))
            Positioned.fill(
              top: 200,
              left: 100,
              child: Column(
                children: [
                  EnterWaterAreaWidget(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
//
