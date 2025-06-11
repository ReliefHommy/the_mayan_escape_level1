import 'package:flutter/material.dart';
import 'package:mayan_level1/effects/angkor_entry.dart';
import 'package:mayan_level1/fade_scene_transit.dart';

//Simple starter code for Level2Scene:
class AngkorMenu extends StatelessWidget {
  const AngkorMenu({super.key});
// 'assets/images/angkor_entry.png',
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background  desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/angkor_entry.png', // your decorative image
            fit: BoxFit.cover,
          )),
          //Background scens
          Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 500, // your original image width
                //height: 1232, // your original image height
                child: Image.asset(
                  'assets/images/angkor_entry.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.50,
            left: screenWidth * 0.40,
            child: Column(
              children: [
                FadeSceneTransition(
                  visible: true,
                  child: Center(
                    child: AngkorEntry(),
                  ),
                ),
                //PuzzleHintWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
