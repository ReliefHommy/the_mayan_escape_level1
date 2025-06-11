import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mayan_level1/text_style.dart';

import '../game_state_maneger.dart';

class WaterPuzzle extends StatefulWidget {
  final VoidCallback onSolved;

  const WaterPuzzle({required this.onSolved, super.key});

  @override
  _WaterPuzzleState createState() => _WaterPuzzleState();
}

class _WaterPuzzleState extends State<WaterPuzzle>
    with SingleTickerProviderStateMixin {
  bool isFilled = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fillBowl() {
    setState(() {
      isFilled = true;
    });
    _controller.forward(); // Start fade animation
    Future.delayed(Duration(seconds: 1), () {
      final gameState = context.read<GameStateManager>();
      gameState.markPuzzleAsSolved('water_offering');
      gameState.collectItem('Hidden Passage Key');
      widget.onSolved();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasWaterVessel =
        context.watch<GameStateManager>().hasItem("Water Basin");

    return AlertDialog(
      backgroundColor: Colors.brown.withOpacity(0.5),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.brown.shade300, width: 2),
      ),
      title: Text(
        "Water Offering Puzzle",
        textAlign: TextAlign.center,
        style: subHeadingTextStyle,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/icons/water_basin.png', width: 80),
              if (isFilled)
                FadeTransition(
                  opacity: _fadeAnimation,
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            isFilled
                ? "The bowl is now full! You found a key!"
                : "Pour water into the bowl to reveal the hidden key.",
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'DM_Sans',
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: hasWaterVessel && !isFilled ? fillBowl : null,
            child: Text(
              "Pour Water",
              style: elevatedButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
