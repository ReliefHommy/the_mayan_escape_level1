import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/exit_to_main.dart';
import 'package:mayan_level1/screens/jungle_entrance.dart';

class DaggerStoryIntroScene extends StatelessWidget {
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

  const DaggerStoryIntroScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ExitToMenuIcon(),

          // Background  desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/dagger_bg.png', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scens
          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 600,
            child: Image.asset(
              'assets/images/dagger_bg.png',
              fit: BoxFit.cover,
            ),
          ))),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // UI-Full-Page Narrative (Cinematic Monologue)

                  Text(
                    "Half-buried in moss and shadow,\n"
                    "a ceremonial dagger rests on a stone pedestal.\n\n"
                    "Its blade glows faintly — not with metal, but with memory.\n"
                    "This is no weapon. It is a key.\n\n"
                    "The moment your hand reaches out,\n"
                    "the jungle holds its breath.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      //height: 1.4,
                      fontFamily: 'CinzelDecorative',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade800.withOpacity(0.9),
                      foregroundColor: Colors.amberAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(
                            color: Colors.amberAccent, width: 1.5),
                      ),
                      elevation: 6,
                      shadowColor: Colors.white,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'CinzelDecorative',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      fadeToScene(
                          context,
                          JungleEntrance(
                            inventory: [],
                            onItemCollected: (item) {},
                            hasAllRequiredItemsExternal: () {},
                          ));

                      //Navigator.pushNamed(context, '/jungle_entrance');
                    },
                    child: Text(
                      "Find out and Collect the Itams ",
                      style: TextStyle(
                        fontFamily: 'CinzelDecorative',
                        fontSize: 16,
                        color: Colors.amberAccent,
                      ),
                    ),
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
