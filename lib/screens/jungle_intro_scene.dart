import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/dagger_story_intro_scene.dart';
import 'package:mayan_level1/text_style.dart';

//MayanIntroScene

class JungleIntroScene extends StatelessWidget {
  //final VoidCallback onCollected;
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

  const JungleIntroScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background  desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/temple_bg.png', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scens
          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 600,
            child: Image.asset(
              'assets/images/temple_bg.png',
              fit: BoxFit.cover,
            ),
          ))),
          Container(color: Colors.black.withOpacity(0.0)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // UI-Full-Page Narrative (Cinematic Monologue)
                  Spacer(
                    flex: 6,
                  ),
                  Text(
                    "Emerge awakened,or not at all.. ,\n"
                    "Step forward-The temple awaits.\n\n",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'CinzelDecorative',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      fadeToScene(context, DaggerStoryIntroScene());
                      //Navigator.pushNamed(context, '/jungle_entrance');
                    },
                    child: Text(
                      "Your Story Begin!",
                      style: elevatedButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
