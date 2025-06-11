import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/game_state_maneger.dart';
import 'package:mayan_level1/screens/dagger_story_intro_scene.dart';
import 'package:mayan_level1/screens/intro_scene.dart';
import 'package:mayan_level1/screens/jungle_entrance.dart';
import 'package:mayan_level1/screens/jungle_intro_scene.dart';
import 'package:mayan_level1/screens/rotating_stone_intro_scene.dart';
import 'package:mayan_level1/screens/temple_entrance.dart';
import 'package:mayan_level1/screens/temple_interior.dart';
import 'package:mayan_level1/screens/water_puzzle_room_screen.dart';
//import 'package:mayan_level1/scene_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameStateManager()),
        //ChangeNotifierProvider(create: (_) => SceneManager()),
      ],
      child: const MayanEscapeGame(),
    ),
  );
}

class MayanEscapeGame extends StatelessWidget {
  const MayanEscapeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mayan Escape',
      initialRoute: '/',
      routes: {
        //'/': (context) => MenuScene(),//TO-DO

        '/': (context) => MayanIntroScene(), //Done

        '/jungle_banner': (context) => JungleIntroScene(),
        //DaggerStoryIntroScene
        '/dagger_story': (context) => DaggerStoryIntroScene(),

        '/jungle_entrance': (context) => JungleEntrance(
              inventory: [],
              onItemCollected: (item) {},
              hasAllRequiredItemsExternal: () {},
            ),
        '/rotating': (context) => RotatingStoneIntroScene(
              onContinue: () {},
            ),
        '/entrance': (context) => TempleEntrance(), //Rotating stone Puzzle

        '/interior': (context) => TempleInterior(), //glyph_puzzle

        //
        '/wateroffer': (context) => WaterPuzzleRoomScreen(), //water_puzzle
        //
      },
    );
  }
}
