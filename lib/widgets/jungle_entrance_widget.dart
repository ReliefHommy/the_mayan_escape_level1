import 'package:flutter/material.dart';
import 'package:mayan_level1/effects/reward_inventory.dart';
import 'package:mayan_level1/screens/rotating_stone_intro_scene.dart';
import 'package:mayan_level1/text_style.dart';

class JungleEntranceWidget extends StatelessWidget {
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
  const JungleEntranceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.0),
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: Colors.orangeAccent, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Well Done!",
              style: headingTextStyle, textAlign: TextAlign.center),
          RewardInventory(),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              elevation: 6,
              shadowColor: Colors.purpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              fadeToScene(
                  context,
                  RotatingStoneIntroScene(
                    onContinue: () {},
                  ));
              //Navigator.pushNamed(context, '/rotating'); // Navigate to entrance
            },
            child: Text(
              "Enter the Temple",
              style: elevatedButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
