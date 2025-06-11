import 'package:flutter/material.dart';
import 'package:mayan_level1/effects/reward_glyph.dart';
import 'package:mayan_level1/text_style.dart';

class OpenWaterRoomWidget extends StatelessWidget {
  const OpenWaterRoomWidget({super.key});

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
          RewardGlyph(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wateroffer');
            },
            child: Text(
              "Enter the Water Room!",
              style: elevatedButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
//Image.asset('assets/temple_entrance_widget.jpg', width: 100);
