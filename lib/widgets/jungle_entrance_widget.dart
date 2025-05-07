import 'package:flutter/material.dart';

class JungleEntranceWidget extends StatelessWidget {
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
              style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
              textAlign: TextAlign.center),
          Text("You are Un Lock The Entrance Now!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/entrance'); // Navigate to entrance
            },
            child: Text("Enter the Temple"),
          ),
        ],
      ),
    );
  }
}
