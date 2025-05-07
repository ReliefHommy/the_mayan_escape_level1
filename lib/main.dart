import 'package:flutter/material.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';
import 'package:mayan_level1/screens/jungle_entrance.dart';
import 'package:mayan_level1/screens/temple_entrance.dart';
import 'package:mayan_level1/screens/temple_interior.dart';
import 'package:mayan_level1/screens/water_room.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameStateManager(),
      child: MayanEscapeGame(),
    ),
  );
}

//
class MayanEscapeGame extends StatelessWidget {
  const MayanEscapeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mayan Escape',
        initialRoute: '/',
        routes: {
          '/': (context) => JungleEntrance(),
          '/entrance': (context) => TempleEntrance(), //Roteting Stone Dial--
          '/temple': (context) => TempleInterior(), //Animal Glyph Puzzle
          '/wateroffer': (context) => WaterRoom(), //WaterPuzzleRoomScreen
        }
        //home: JungleEntrance(),
        );
  }
}
//
