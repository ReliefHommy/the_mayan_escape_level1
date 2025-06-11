import 'package:flutter/material.dart';
import 'package:mayan_level1/effects/reward_rotating.dart';
import 'package:mayan_level1/text_style.dart';

class TempleEntranceWidget extends StatelessWidget {
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
          Text("Well Done!",
              style: headingTextStyle, textAlign: TextAlign.center),
          RewardRotating(),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/interior'); // Navigate to entrance
            },
            child: Text(
              "Enter the Temple Interior",
              style: elevatedButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
