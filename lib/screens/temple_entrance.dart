import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/effects/rotating_hint.dart';
import 'package:mayan_level1/widgets/temple_entrance_widget.dart';
import '../../../game_state_maneger.dart';
import '../../../widgets/puzzle_rotate_stone.dart';

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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background  desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/rotating_scene_bg.jpg', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scens
          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 500,
            child: Image.asset(
              'assets/images/rotating_scene_bg.jpg',
              fit: BoxFit.cover,
            ),
          ))),

          // ---Rotating Stone Dial--

          Positioned(
            //top: 400,
            //left: 150,
            top: screenHeight * 0.30, // 30% from the top
            left: screenWidth * 0.20,
            child: Tooltip(
              message: "Rotating Stone Dial",
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
                  'assets/icons/rotating_stone_icon.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),

          Positioned(
              top: screenHeight * 0.30, // 30% from the top
              left: screenWidth * 0.30, //
              child: Column(
                children: [RotatingHint()],
              )),
//PuzzleHintWidget(),
          //  Inventory Bar at the Bottom

          Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Tooltip(
                message:
                    "There're a mechanism hidden in the Rotating Stone Dial!",
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
          //if (context.watch<GameStateManager>().isPuzzleSolved('animal_glyph'))
          if (context
              .watch<GameStateManager>()
              .isPuzzleSolved('rotating_stone_dial'))
            Positioned(
              bottom: screenHeight * 0.20,
              left: screenWidth * 0.40,
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
