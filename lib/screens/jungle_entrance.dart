import 'package:flutter/material.dart';
import 'package:mayan_level1/widgets/jungle_entrance_widget.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';

class JungleEntrance extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  JungleEntrance({super.key});

  @override
  State<JungleEntrance> createState() => _JungleEntranceState();
}

class _JungleEntranceState extends State<JungleEntrance> {
  String? selectedPuzzle;
  final List<String> requiredItems = [
    'Ceremonial Dagger',
    'Feathered Serpent Statue',
    'Torch'
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
      body: Stack(
        children: [
          // Temple Entrance Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/jungle_entrance.jpg',
              //width: 565,
              //height: 870,
              fit: BoxFit.cover, // Fills the screen proportionally
            ),
          ),

          // -Inventory-1 :Ceremonial Dagger - Collect Item
          if (!context
              .watch<GameStateManager>()
              .hasItem('Ceremonial Dagger')) //Remove image from scene
            Positioned(
              top: screenHeight * 0.30, // 30% from the top
              left: screenWidth * 0.10, // 10% from the left
              child: Tooltip(
                message: "Ceremonial Dagger-Cut the vines",
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<GameStateManager>()
                        .collectItem('Ceremonial Dagger');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('You collected A Ceremonial Dagger!')),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/ceremonial_dagger.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
          // --Inventory-2 :A Torch - Collect Item
          if (!context
              .watch<GameStateManager>()
              .hasItem('Torch')) //Remove image from scene
            Positioned(
              top: screenHeight * 0.16,
              left: screenWidth * 0.38,
              child: Tooltip(
                message: "Torch-Ligh up the dark",
                child: GestureDetector(
                  child: Image.asset(
                    'assets/icons/torch.png',
                    width: 80,
                    height: 80,
                  ),
                  onTap: () {
                    context.read<GameStateManager>().collectItem('Torch');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You collected A Torch!')),
                    );
                  },
                ),
              ),
            ),
          //--Inventory-3Feathered Serpent Statue - Collect Item
          if (!context
              .watch<GameStateManager>()
              .hasItem('Feathered Serpent Statue')) //Remove image from scene
            Positioned(
              top: screenHeight * 0.60,
              left: screenWidth * 0.75,
              child: Tooltip(
                message: "Feathered Serpent Statue",
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<GameStateManager>()
                        .collectItem('Feathered Serpent Statue');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'You collected the Feathered Serpent Statue!')),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/feathered_serpent_statue.png',
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
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.lightGreenAccent, width: 2),
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
// Unlock the Puzzle if all required items collected
          if (hasAllRequiredItems(context))
            Positioned.fill(
              top: 240,
              left: 20,
              child: Column(
                children: [
                  JungleEntranceWidget(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
