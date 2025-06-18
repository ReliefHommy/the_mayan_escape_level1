import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/angkor_menu.dart';
import 'package:mayan_level1/screens/exit_to_main.dart';
import 'package:mayan_level1/text_style.dart';
//import 'package:audioplayers/audioplayers.dart';

// 'assets/images/final_scene.png',

class MayanFinalScene extends StatelessWidget {
  //final VoidCallback onCollected;˝
  //final player =
  //AudioPlayer(); // You can move this to a global or state variable
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

  const MayanFinalScene({super.key});

  @override
  Widget build(BuildContext context) {
    //final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background  desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/final_scene.png', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scens
          Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 500, // your original image width
                //height: 1232, // your original image height
                child: Image.asset(
                  'assets/images/final_scene.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.0)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // UI-Full-Page Narrative (Cinematic Monologue)

                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      fadeToScene(context, AngkorMenu());
                      //player.play(AssetSource('audio/mayan_intro.mp3'));
                    },
                    child:
                        Text("Go to Level 2!", style: elevatedButtonTextStyle),
                  ),
                ],
              ),
            ),
          ),
          ExitToMenuIcon(),
        ],
      ),
    );
  }
}
