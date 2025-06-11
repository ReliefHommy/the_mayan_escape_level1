import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/water_offering_scene.dart';

class EnterWaterAreaWidget extends StatelessWidget {
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

  const EnterWaterAreaWidget({super.key, required Null Function() onComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Well Done!",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center),
          Text("You are Un Lock The Water Offering Ritual Now!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              fadeToScene(
                  context,
                  WaterOfferingComicScene(
                    onComplete: () {},
                  ));
            },
            child: Text("Enter the Water Room!"),
          ),
        ],
      ),
    );
  }
}
