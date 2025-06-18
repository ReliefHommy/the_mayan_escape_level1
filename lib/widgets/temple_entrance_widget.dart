import 'package:flutter/material.dart';

class TempleEntranceWidget extends StatelessWidget {
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
  const TempleEntranceWidget({super.key});

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
          //
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.brown.shade900.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: Colors.white.withOpacity(0.9), width: 2),
            ),
            child: const Text(
              "You have unlocked the Temple Interior!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Georgia',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          //

          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            //
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown.shade800.withOpacity(0.9),
              foregroundColor: Colors.amberAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Colors.amberAccent, width: 1.5),
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
            //
            onPressed: () {
              Navigator.pushNamed(context, '/interior'); // Navigate to entrance
            },
            child: Text(
              "Enter the Temple Interior",
              style: TextStyle(
                fontFamily: 'CinzelDecorative',
                fontSize: 16,
                color: Colors.amberAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
