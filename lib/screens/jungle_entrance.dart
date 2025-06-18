import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/exit_to_main.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/fade_scene_transit.dart';
import 'package:mayan_level1/game_state_maneger.dart';
import 'package:mayan_level1/widgets/jungle_entrance_widget.dart';

class JungleEntrance extends StatefulWidget {
  final Map<String, String> inventoryIcons = {};
  JungleEntrance(
      {super.key,
      required List inventory,
      required Null Function(dynamic item) onItemCollected,
      required Function() hasAllRequiredItemsExternal});

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

  get player => null;
  bool hasAllRequiredItems(BuildContext context) {
    final gameState = context.watch<GameStateManager>();
    return requiredItems.every(gameState.hasItem);
  }

  //
  void fadeToScene(BuildContext context, Widget nextScene) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => nextScene,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
//

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
            'assets/images/inventory_scene_bg.jpg', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scens
          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 500,
            child: Image.asset(
              'assets/images/inventory_scene_bg.jpg',
              fit: BoxFit.cover,
            ),
          ))),

          // -Inventory-1 :Ceremonial Dagger - Collect Item
          if (!context
              .watch<GameStateManager>()
              .hasItem('Ceremonial Dagger')) //Remove image from scene
            Positioned(
              top: screenHeight * 0.35, // 30% from the top
              left: screenWidth * 0.60, // 10% from the left
              child: Tooltip(
                message: "Collect a Ceremonial Dagger!",
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
                      'assets/icons/ceremonial_dagger.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
            ),
          if (!context
              .watch<GameStateManager>()
              .hasItem('Torch')) //Remove image from scene

            // --Inventory-2 :A Torch - Collect Item
            if (!context
                .watch<GameStateManager>()
                .hasItem('Torch')) //Remove image from scene
              Positioned(
                top: screenHeight * 0.40,
                left: screenWidth * 0.15,
                child: Tooltip(
                  message: "Collect a Torch!",
                  child: GestureDetector(
                    onTap: () {
                      context.read<GameStateManager>().collectItem('Torch');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You collected A Torch!')),
                      );

                      // your original logic
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
                        'assets/icons/torch.png',
                        width: 60,
                        height: 60,
                      ),
                    ),

                    //
                  ),
                ),
              ),
          //--Inventory-3Feathered Serpent Statue - Collect Item
          if (!context
              .watch<GameStateManager>()
              .hasItem('Feathered Serpent Statue')) //Remove image from scene
            Positioned(
              top: screenHeight * 0.70,
              left: screenWidth * 0.50,
              child: Tooltip(
                message: "Collect a Feathered Serpent Statue!",
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
                      'assets/icons/feathered_serpent_statue.png',
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
              bottom: 30,
              left: 20,
              right: 20,
              child: Tooltip(
                message: "There're 3 secret objects needs to Collected!",
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
                          padding: EdgeInsets.all(2),
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
              )),
// Unlock the Puzzle if all required items collected
          if (hasAllRequiredItems(context))
            Positioned(
              bottom: screenHeight * 0.20,
              left: screenWidth * 0.40,
              //bottom: 200,
              //left: 100,
              child: Column(
                children: [
                  FadeSceneTransition(
                    visible: true,
                    child: Center(
                      child: JungleEntranceWidget(),
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
