import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/exit_to_main.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/fade_scene_transit.dart';
import 'package:mayan_level1/widgets/glyph_puzzle_widget.dart';
import 'package:mayan_level1/widgets/open_water_room_widget.dart';
import '../../../game_state_maneger.dart';

class TempleInterior extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  TempleInterior({super.key});

  @override
  State<TempleInterior> createState() => _TempleInteriorState();
}

class _TempleInteriorState extends State<TempleInterior> {
  String? selectedPuzzle;
  final List<String> requiredItems = ['Passed Key', 'Water Holder'];
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
            'assets/images/temple_interior_glyphs.jpg', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scenes

          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 700,
            child: Image.asset(
              'assets/images/temple_interior_glyphs.jpg',
              fit: BoxFit.cover,
            ),
          ))),

          //   3-Inventory ---Hidden Passage Key appear---after Glyph puzzle solved!
          if (context.watch<GameStateManager>().isPuzzleSolved('animal_glyph'))
            Positioned(
              top: screenHeight * 0.50,
              left: screenWidth * 0.10,
              //top: 350,
              //left: 80,
              child: Tooltip(
                message: "A Passage Key!",
                child: GestureDetector(
                  onTap: () {
                    context.read<GameStateManager>().collectItem('Passed Key');
                  },

                  //
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.brown.withOpacity(0.2), width: 2),
                    ),
                    child: Image.asset(
                      'assets/icons/passed_key.png',
                      width: 60,
                      height: 60,
                    ),
                  ),

                  //
                ),
              ),
            ),

// Water blow appearen when the golden key kollected!
          //   4-Inventory ---Water Bowl---
          if (context.watch<GameStateManager>().hasItem('Passed Key'))
            Positioned(
              top: screenHeight * 0.70, // 30% from the top
              left: screenWidth * 0.10, // 10% from the left

              child: Tooltip(
                message: "A Water Holder!",
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<GameStateManager>()
                        .collectItem('Water Holder');
                  },
                  //water_holder
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.brown.withValues(), width: 2),
                    ),
                    child: Image.asset(
                      'assets/icons/water_holder.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
            ),

          // ---Animal Glyph Puzzle--
          // Only show the icon if the puzzle is NOT solved yet
          if (!context.watch<GameStateManager>().isPuzzleSolved('animal_glyph'))
            Positioned(
              top: screenHeight * 0.60, // 30% from the top
              left: screenWidth * 0.40, // 10% from the left

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
                  //
                  //
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.brown.withOpacity(0.2), width: 2),
                    ),
                    child: Image.asset(
                      'assets/icons/animal_glyph.png',
                      width: 60,
                      height: 60,
                    ),
                  ),

                  //
                ),
              ),
            ),

          //  Inventory Bar at the Bottom

          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Tooltip(
                message: "Animal Glyph Puzzle Hides somewhere on The Door!",
                child: Container(
                  height: 80,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
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
                            color: Colors.white.withOpacity(0.5),
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
                //
              )),
          if (hasAllRequiredItems(context))
            Positioned(
              bottom: screenHeight * 0.20,
              left: screenWidth * 0.40,
              child: Column(
                children: [
                  FadeSceneTransition(
                    visible: true,
                    child: Center(
                      child: OpenWaterRoomWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ExitToMenuIcon(),
        ],
      ),
    );
  }
}
