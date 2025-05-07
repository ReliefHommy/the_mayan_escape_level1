import 'package:flutter/material.dart';

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
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center),
          Text("You are Un Lock The Temple Interior Now!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/temple'); // Navigate to entrance
            },
            child: Text("Enter the Temple Interior"),
          ),
        ],
      ),
    );
  }
}
